
selector = config["selector"]
source_elem = config["source_elem"]
wrap_elem_type = config["wrap_elem"]
wrap_class = config["wrap_class"]

menu = HTML.select_one(page, selector)
elems = HTML.select(menu, source_elem)

index, elem = next(elems)
while index do
  wrap_elem = HTML.create_element(wrap_elem_type, "")
  HTML.add_class(wrap_elem, wrap_class)
  HTML.append_child(wrap_elem, elem)
  HTML.append_child(menu, wrap_elem)

  index, elem = next(elems, index)
end
