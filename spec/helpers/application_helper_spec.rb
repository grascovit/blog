# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#flash_message_class' do
    context 'when flash is a notice' do
      it 'returns the positive CSS class' do
        expect(helper.flash_message_class('notice')).to eq('positive')
      end
    end

    context 'when flash is an alert' do
      it 'returns the negative CSS class' do
        expect(helper.flash_message_class('alert')).to eq('negative')
      end
    end
  end
end
