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

    let(:json) { JSON.parse(response.body) }
    let(:graph) { Graph.create!(valid_attributes) }
    let(:valid_line_attributes) do
      {
        option: 'foo',
        metric: 'bar',
        extractor: 'count',
      }
    end

    let(:graph_w_line) do 
      g = Graph.create!(valid_attributes) 
      g.graph_lines.create!(valid_line_attributes)
      g
    end

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

    describe "GET 'show'" do
      it "renders the JSON representation of the graph" do
        get :show, id: graph.id
        response.should be_success
        json['title'].should == graph.title
        json['extractors'].should == []
      end

      it "returns one extractor per graph line" do
        get :show, id: graph_w_line
        response.should be_success
        json['extractors'].count.should == 1
        ext = json['extractors'].first
        ext['key'].should == valid_line_attributes[:extractor]
        ext['url'].should be_present
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
            "0" => valid_line_attributes
          }
        }
      end

      it "Add the graph line" do
        put :update, id: graph.id, graph: update_attrs
        response.should be_redirect
        graph.reload.graph_lines.size.should == 1
      end
    end
  end
end
