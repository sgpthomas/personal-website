-- Highlights the link to the current section in the menu
-- Quite hacky, if you ask me

active_link_class = config["active_link_class"]
nav_menu_selector = config["selector"]
source_elem = config["source_elem"]

menu = HTML.select_one(page, nav_menu_selector)
elems = HTML.select(menu, source_elem)

index, elem = next(elems)
while index do
  link = HTML.select_one(elem, "a")
  href = strlower(HTML.get_attribute(link, "href"))

  if href ~= "/" then
    if Regex.match(page_file, href) then
      HTML.add_class(elem, active_link_class)
    end
  else
    if Regex.match(page_file, "site/index.html") then
      HTML.add_class(elem, active_link_class)
    end
  end
  index, elem = next(elems, index)
end
