# ScenicDriverGPIO

GPIO input driver for [Scenic](https://github.com/boydm/scenic).
Map GPIO high / low events to input events.

## Installation

he package can be installed by adding `scenic_driver_gpio` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:scenic_driver_gpio, "~> 0.1"}
  ]
end
```

The docs can be found at [https://hexdocs.pm/scenic_driver_gpio](https://hexdocs.pm/scenic_driver_gpio).

## Usage

ScenicDriverGPIO maps input events to high and low GPIO states. This is useful
when using GPIOs for buttons such as on a gamepad. The configuration for a button
requires the following parameters.

* pin - The GPIO pin to use as an input
* pull_mode - Connect or disconnect an internal pull-up or pull-down resistor to
  the GPIO pin
* low: The scenic input event to trigger when the pin goes high to low
* high: The scenic input event to trigger when the pin goes from low to high

The following example configures the driver for use with the Adafruit OLED Bonnet.
Information about which GPIO pins the bonnet uses can be found [here](https://pinout.xyz/pinout/oled_bonnet)

```elixir
config :nerves_game, :viewport, %{
  name: :main_viewport,
  # ...
  drivers: [
    %{
      module: ScenicDriverGPIO,
      opts: [
        %{pin: 4,  pull_mode: :pullup, low: {:key, {" ", :press, 0}}, high: {:key, {" ", :release, 0}}}, # Joystick press
        %{pin: 17, pull_mode: :pullup, low: {:key, {"w", :press, 0}}, high: {:key, {"w", :release, 0}}}, # Joystick up
        %{pin: 23, pull_mode: :pullup, low: {:key, {"d", :press, 0}}, high: {:key, {"d", :release, 0}}}, # Joystick right
        %{pin: 22, pull_mode: :pullup, low: {:key, {"s", :press, 0}}, high: {:key, {"s", :release, 0}}}, # Joystick down
        %{pin: 27, pull_mode: :pullup, low: {:key, {"a", :press, 0}}, high: {:key, {"a", :release, 0}}}, # Joystick left
        %{pin: 5,  pull_mode: :pullup, low: {:key, {"l", :press, 0}}, high: {:key, {"l", :release, 0}}}, # #5
        %{pin: 6,  pull_mode: :pullup, low: {:key, {"p", :press, 0}}, high: {:key, {"p", :release, 0}}}, # #6
      ]
    }
  ]
```
