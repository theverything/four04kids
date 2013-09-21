require 'spec_helper'
describe "API routing" do
  it "maps to correct controller methods" do
    expect(get: "/api/random").to route_to(
      controller: "api",
      action: "random"
    )
    expect(get: "/api/show").to route_to(
      controller: "api",
      action: "show"
    )
    expect(get: "/api/index").to route_to(
      controller: "api",
      action: "index"
    )
  end
end