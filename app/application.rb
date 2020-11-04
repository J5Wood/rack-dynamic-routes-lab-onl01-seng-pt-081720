class Application

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match("/items/")
            current_items = []
            @@items.each {|item| current_items << item.name}
            requested_item = req.path.split("/items/").last
            
            if current_items.include?(requested_item)
                resp.write @@items.select{|i| i.name ==  requested_item}[0].price
            else
                resp.write "Item not found"
                resp.status = 400
            end
        else
            resp.write "Route not found"
            resp.status = 404
        end
        resp.finish
    end
end