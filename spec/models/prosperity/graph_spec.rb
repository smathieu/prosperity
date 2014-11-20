require 'spec_helper'

module Prosperity
  describe Graph, type: :model do
    describe "#valid?" do
      it { should allow_value('line').for(:graph_type) }
      it { should allow_value('area').for(:graph_type) }
      it { should_not allow_value('whatever').for(:graph_type) }
      it { should_not allow_value(nil).for(:graph_type) }
      it { should_not allow_value("").for(:graph_type) }
    end
  end
end
