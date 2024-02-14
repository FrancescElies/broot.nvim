local plugin = require("broot")

describe("setup", function()
  it("works with default", function()
    assert(plugin.broot() == "Hello!", "my first function with param = Hello!")
  end)

  it("works with custom var", function()
    plugin.setup({ opt = "custom" })
    assert(plugin.broot() == "custom", "my first function with param = custom")
  end)
end)
