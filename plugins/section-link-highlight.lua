active_link_class = config["active_link_class"]
nav_menu_selector = config["selector"]
source_elem = config["source_elem"]

if (not active_link_class) then
  Log.warning("active_link_class option is not set, using default (\"active\")")
  active_link_class = "active"
end

if (not nav_menu_selector) then
  Log.warning("nav_menu_selector option is not set, using default (\"nav\")")
  nav_menu_selector = "nav"
end

if (not source_elem) then
  Log.warning("source_elem option is not set, using default (\"a\")")
  source_elem = "a"
end

menu = HTML.select_one(page, nav_menu_selector)
if not menu then
  Plugin.exit("Could not find an element matching the navigation menu selector")
end

elems = HTML.select(menu, source_elem)

index, elem = next(elems)
while index do
  link = HTML.select_one(elem, "a")
  href = strlower(HTML.get_attribute(link, "href"))

  -- Remove leading and trailing slashes
  href = Regex.replace_all(href, "(\\/?$|^\\/)", "")
  page_url = Regex.replace_all(page_url, "(\\/?$|^\\/)", "")

  -- Normalize slashes
  href = Regex.replace_all(href, "\\/+", "\\/")

  -- Edge case: the / link that becomes "" after normalization
  -- Anything would match the empty string and higlight all links,
  -- so we handle this case explicitly
  if ((page_url == "") and (href == ""))
    or ((href ~= "") and Regex.match(page_url, "^" .. href))
  then
    HTML.add_class(elem, active_link_class)
  end

  index, elem = next(elems, index)
end
