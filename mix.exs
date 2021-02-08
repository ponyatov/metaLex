defmodule Hello.MixProject do
  use Mix.Project

  def project do
    [
      app: :hello,
      description: "metaL: implementation in Erlang/Elixir",
      author: "Dmitry Ponyatov",
      version: "0.0.1",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:cowboy, "~> 2.8"}
    ]
  end
end
