json.id @product.id
json.price @product.price
json.title @product.name
json.description @product.description
json.img_url @product.img_url
json.is_discounted @product.is_discounted
json.supplier_name @product.supplier.name
#delete image lines when we resolve the last migrate and db:seed, do in index as well as the controllers having image_url