product1 = Product.new(name: 'soap', price: 3, description:'it cleans you in the bath!', img_url: "" )
product2 = Product.new(name: 'table', price: 45, description: "object to put things on", img_url: "" )
product2.save

products = Product.all

products.each do |product|
  Image.create!(
    url: product.image_url,
    product_id: product.product_id
    )
end