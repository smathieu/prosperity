require 'spec_helper'

module Prosperity
  describe Graph, type: :model do
    describe "#valid?" do
      it { is_expected.to allow_value('line').for(:graph_type) }
      it { is_expected.to allow_value('area').for(:graph_type) }
      it { is_expected.not_to allow_value('whatever').for(:graph_type) }
      it { is_expected.not_to allow_value(nil).for(:graph_type) }
      it { is_expected.not_to allow_value("").for(:graph_type) }
    end
  end
end
