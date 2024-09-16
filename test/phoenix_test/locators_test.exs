defmodule PhoenixTest.LocatorsTest do
  use ExUnit.Case, async: true

  alias PhoenixTest.Locators

  describe "textbox" do
    test "includes provided label" do
      {:textbox, data} = Locators.textbox(label: "Hello")

      assert data.label == "Hello"
    end

    test "has list of valid roles" do
      valid_roles =
        ~w|input:not([type]) input[type="text"] input[type="tel"] input[type="email"] input[type="url"] textarea|

      {:textbox, data} = Locators.textbox(text: "doesn't matter")

      assert data.roles == valid_roles
    end
  end

  describe "button" do
    test "includes provided text" do
      {:button, data} = Locators.button(text: "Hello")

      assert data.text == "Hello"
    end

    test "has list of valid roles" do
      valid_roles = ~w|button input[type="button"] input[type="image"] input[type="reset"] input[type="submit"]|

      {:button, data} = Locators.button(text: "doesn't matter")

      assert data.roles == valid_roles
    end
  end

  describe "role_locators for button" do
    test "returns {'button', text} in list" do
      locator = Locators.button(text: "Hello")

      roles = Locators.role_selectors(locator)

      assert {"button", "Hello"} in roles
    end

    test "returns text in selector for other roles" do
      locator = Locators.button(text: "Hello")

      roles = Locators.role_selectors(locator)

      assert ~s|input[type="button"][value="Hello"]| in roles
    end
  end

  describe "role_selectors for textbox" do
    test "returns list of valid roles" do
      locator = Locators.textbox(label: "Doesn't matter")
      {:textbox, data} = locator

      roles = Locators.role_selectors(locator)

      assert roles == data.roles
    end
  end
end
