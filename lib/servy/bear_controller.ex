defmodule Servy.BearController do
  alias Servy.Wildthings

  @templates_path Path.expand("../../templates", __DIR__)
  def index(conv) do
    bears = Wildthings.list_bears()
    inspect(bears)

    content =
      @templates_path
      |> Path.join("index.eex")
      |> EEx.eval_file(bears: bears)

    %{conv | status: 200, resp_body: content}
  end

  def show(conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)

    IO.inspect(bear, label: "INSPECTION of bear: ")

    content =
      @templates_path
      |> Path.join("show.eex")
      |> EEx.eval_file(bear: bear)

    IO.inspect(content, label: "INSPECTION of content: ")
    %{conv | status: 200, resp_body: content}
  end

  def create(conv, params) do
    %{
      conv
      | status: 201,
        resp_body: "Created a #{params["type"]} bear named #{params["name"]}!"
    }
  end
end
