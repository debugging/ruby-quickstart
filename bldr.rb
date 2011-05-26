require "builder"

b = Builder::XmlMarkup.new
page = b.html do |h|
  h.head {|head| head.title("page title") }
  h.body {|body| body.a("link text", "href" => "a1") }
end


