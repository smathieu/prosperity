require 'spec_helper'

module Prosperity
  describe GraphsController do
    routes { Prosperity::Engine.routes }

    let(:valid_attributes) do
      {
        title: "My Graph",
        period: "month",
      }
    end

    let(:invalid_attributes) do
      {graph: {}}
    end

    let(:graph) { Graph.create!(valid_attributes) }

    describe "GET 'new'" do
      it "returns http success" do
        get 'new'
        response.should be_success
        assigns(:graph).should be_a(Graph)
      end
    end

    describe "GET 'edit'" do
      it "returns http success" do
        get 'edit', id: graph.id
        response.should be_success
        assigns(:graph).should == graph
      end
    end

    describe "POST create" do
      it "should create a new graph with the correct attributes" do
        expect do 
          post :create, graph: valid_attributes
        end.to change(Graph, :count).by(1)
        graph = assigns(:graph)
        response.should redirect_to(edit_graph_path(graph))
      end

      it "handles invalid attributes" do
        post :create, graph: invalid_attributes
        response.should be_success
        flash[:error].should be_present
      end
    end

    describe "PUT update" do 
      let(:update_attrs) do
        {
          "graph_lines_attributes" => {
            "0" => {
              "option" => "My option", 
              "metric" => "lol"
            }
          }
        }
      end

      it "Add the graph line" do
        put :update, id: graph.id, graph: update_attrs
        response.should be_redirect
        graph.graph_lines.size.should == 1
      end
    end
  end
end
