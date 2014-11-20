require 'spec_helper'

module Prosperity
  describe GraphsController, type: :controller do
    routes { Prosperity::Engine.routes }

    let(:valid_attributes) do
      {
        title: "My Graph",
        period: "month",
        graph_type: 'line',
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
        expect(response).to be_success
        expect(assigns(:graph)).to be_a(Graph)
      end
    end

    describe "GET 'edit'" do
      it "returns http success" do
        get 'edit', id: graph.id
        expect(response).to be_success
        expect(assigns(:graph)).to eq(graph)
      end
    end

    describe "GET 'show'" do
      context "in JSON" do
        it "renders the JSON representation of the graph" do
          get :show, id: graph.id, format: 'json'
          expect(response).to be_success
          expect(json['title']).to eq(graph.title)
          expect(json['extractors']).to eq([])
        end

        it "returns one extractor per graph line" do
          get :show, id: graph_w_line, format: 'json'
          expect(response).to be_success
          expect(json['extractors'].count).to eq(1)
          ext = json['extractors'].first
          expect(ext['key']).to eq(valid_line_attributes[:extractor])
          expect(ext['url']).to be_present
        end
      end

      context "as embedabble HTML" do
        before do
          get :show, id: graph.id, format: 'html'
          expect(response).to be_success
        end

        it "renders html" do
          expect(response.content_type).to eq('text/html')
          expect(response.body).to include('metric dashboard')
        end

        it "should render the embedabble layout" do
          expect(response.body).not_to include('navbar')
        end

        it "404 with custom page when graph is not found" do
          get :show, id: :unknown_id, format: 'html'
          expect(response.status).to eq(404)
          expect(response.body).to include("No such graph")
        end
      end
    end

    describe "POST create" do
      it "should create a new graph with the correct attributes" do
        expect do 
          post :create, graph: valid_attributes
        end.to change(Graph, :count).by(1)
        graph = assigns(:graph)
        expect(response).to redirect_to(edit_graph_path(graph))
      end

      it "handles invalid attributes" do
        post :create, graph: invalid_attributes
        expect(response).to be_success
        expect(flash[:error]).to be_present
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
        expect(response).to be_redirect
        expect(graph.reload.graph_lines.size).to eq(1)
      end

      let(:line) { graph_w_line.graph_lines.first }
      let(:update_line_attrs) do
        {
          "graph_lines_attributes" => {
            "0" => {
              id: line.id,
              option: 'new_option',
              extractor: 'interval'
            }
          }
        }
      end

      it "updates an existing line" do
        put :update, id: graph_w_line.id, graph: update_line_attrs
        expect(response).to be_redirect
        line = graph_w_line.reload.graph_lines.first
        expect(line.option).to eq('new_option')
        expect(line.extractor).to eq('interval')
      end

      let(:destroy_line_attrs) do
        {
          "graph_lines_attributes" => {
            "0" => {
              id: line.id,
              _destroy: true,
            }
          }
        }
      end

      it "can destroy an existing line" do
        put :update, id: graph_w_line.id, graph: destroy_line_attrs
        expect(response).to be_redirect
        expect(GraphLine.find_by(id: line.id)).to be_nil
      end

      it "updates an existing line while ignoring blank ones" do
        line = graph.graph_lines.create!(valid_line_attributes)

        attrs = {
          "graph_lines_attributes"=>{
            "0"=>{
              "option"=>"default", 
              "metric"=>"UsersMetric", 
              "extractor"=>"interval", 
              "id"=> line.id,
            }, "1"=>{
              "option"=>"default", 
              "metric"=>"", 
              "extractor"=>"change"
            }
          }
        }

        put :update, id: graph.id, graph: attrs
        expect(response).to be_redirect
        expect(line.reload.extractor).to eq('interval')
        expect(graph.reload.graph_lines.count).to eq(1)
      end
    end
  end
end
