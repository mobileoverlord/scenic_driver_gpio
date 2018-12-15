defmodule ScenicDriverGPIO do
  use Scenic.ViewPort.Driver

  alias Scenic.ViewPort
  alias Circuits.GPIO

  @high 1
  @low 0

  def init(viewport, _size, config) do
    {:ok, %{
      gpio: init_gpio(config),
      viewport: viewport
    }}
  end

  defp init_gpio(map) do
    Enum.reduce(map, [], fn(gpio, acc) ->
      pin = gpio.pin || raise "No pin was defined"
      pull_mode = gpio.pull_mode || :none

      {:ok, gpio_ref} = GPIO.open(pin, :input)
      :ok = GPIO.set_pull_mode(gpio_ref, pull_mode)
      :ok = GPIO.set_edge_mode(gpio_ref, :both)
      [Map.put(gpio, :ref, gpio_ref) | acc]
    end)
  end

  def handle_info({:gpio, pin, _, edge}, s) do
    gpio = Enum.find(s.gpio, & &1.pin == pin)

    event =
      case edge do
        @high -> Map.get(gpio, :high)
        @low -> Map.get(gpio, :low)
      end

    ViewPort.input(s.viewport, event)

    {:noreply, s}
  end
end
