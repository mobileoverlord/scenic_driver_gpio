defmodule ScenicDriverGPIO do
  use Scenic.ViewPort.Driver

  alias Scenic.ViewPort
  alias Circuits.GPIO

  @high 1
  @low 0

  def init(viewport, _size, config) do
    {:ok,
     %{
       gpio: init_gpio(config),
       viewport: viewport
     }}
  end

  defp init_gpio(config) do
    Enum.reduce(config, %{}, fn gpio, acc ->
      pin = gpio[:pin] || raise "No pin was defined"
      pull_mode = gpio[:pull_mode] || :not_set

      {:ok, gpio_ref} = GPIO.open(pin, :input)
      :ok = GPIO.set_pull_mode(gpio_ref, pull_mode)
      :ok = GPIO.set_interrupts(gpio_ref, :both)

      info = Map.put(gpio, :ref, gpio_ref)
      Map.put(acc, pin, info)
    end)
  end

  def handle_info({:gpio, pin, _, edge}, s) do
    gpio = Map.get(s.gpio, pin)

    event =
      case edge do
        @high -> Map.get(gpio, :high)
        @low -> Map.get(gpio, :low)
      end

    ViewPort.input(s.viewport, event)

    {:noreply, s}
  end
end
