module Selectors
  Capybara.add_selector(:linkhref) do
    xpath {|href| ".//a[@href='#{href}']"}
  end

  Capybara.add_selector(:deletehref) do
    xpath {|href| ".//a[@href='#{href}'][@data-method='delete']"}
  end
end
