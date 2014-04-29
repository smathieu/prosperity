shared_examples "an extractor" do
  AGGREGATES = [:sum, :minimum, :maximum, :average]
  let(:expected_data_size) { 14 }

  ["sql", "normal"].each do |type|
    AGGREGATES.each do |agg|
      context "a #{type} metric with aggregate #{agg}" do
        let(:metric) do
          Class.new(Prosperity::Metric) do
            if type == 'sql'
              sql "SELECT * FROM users"
            else
              scope { User }
            end
            aggregate { send(agg, :value) }
          end.new
        end

        describe "#to_a" do
          let(:data) { subject.to_a }
          it "returns the one entry per period" do
            data.size.should == expected_data_size
          end
        end
      end
    end

    context "a sql metric with default aggregat" do
      let(:metric) do
        Class.new(Prosperity::Metric) do
          if type == 'sql'
            sql "SELECT * FROM users"
          else
            scope { User }
          end
        end.new
      end

      describe "#to_a" do
        let(:data) { subject.to_a }
        it "returns the one entry per period" do
          data.size.should == expected_data_size
        end
      end
    end
  end

  context "a full SQL metric" do
    let(:metric) do
      Class.new(Prosperity::Metric) do
        sql "SELECT * FROM users"
        group_by "created_at"
        aggregate { "SUM(value)" }
      end.new
    end

    describe "#to_a" do
      let(:data) { subject.to_a }
      it "returns the one entry per period" do
        data.size.should == expected_data_size
      end
    end
  end
end
