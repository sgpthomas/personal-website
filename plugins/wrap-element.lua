
selector = config["selector"]
source_elem = config["source_elem"]
wrap_elem_type = config["wrap_elem"]
wrap_class = config["wrap_class"]

menu = HTML.select_one(page, selector)
elems = HTML.select(menu, source_elem)

count = 0
index, _ = next(elems)
while index do
  count = count + 1
  index, _ = next(elems, index)
end

index = 1
while elems[index] do
  elem = elems[index]
  wrap_elem = HTML.create_element(wrap_elem_type, "")
  HTML.add_class(wrap_elem, wrap_class)
  HTML.append_child(wrap_elem, elem)
  HTML.append_child(menu, wrap_elem)
  index = index + 1
end
