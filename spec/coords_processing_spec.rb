# frozen_string_literal: true

require_relative '../lib/coords_processing'

describe CoordsProcessing do
  let(:dummy_class) { Class.new { extend CoordsProcessing } }

  describe '#vertical_adjacent_coords' do
    context 'when passed algebraic coordinates "e4"' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns an array of vertical adjacent coordinates' do
        result = dummy_class.vertical_adjacent_coords(algebraic_e4)
        expect(result).to match_array(%w[e1 e2 e3 e5 e6 e7 e8])
      end
    end
  end

  describe '#horizontal_adjacent_coords' do
    context 'when passed algebraic coordinates "e4"' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns an array of horizontal adjacent coordinates' do
        result = dummy_class.horizontal_adjacent_coords(algebraic_e4)
        expect(result).to match_array(%w[a4 b4 c4 d4 f4 g4 h4])
      end
    end
  end

  describe '#top_left_diagonal_adjacent_coords' do
    context 'when passed algebraic coordinates "e4"' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns an array of top left diagonal adjacent coordinates' do
        result = dummy_class.top_left_diagonal_adjacent_coords(algebraic_e4)
        expect(result).to match_array(%w[a8 b7 c6 d5])
      end
    end

    context 'when passed algebraic coordinates "c3"' do
      subject(:algebraic_c3) { 'c3' }

      it 'returns an array of top left diagonal adjacent coordinates' do
        result = dummy_class.top_left_diagonal_adjacent_coords(algebraic_c3)
        expect(result).to match_array(%w[a5 b4])
      end
    end

    context 'when passed algebraic coordinates "a8"' do
      subject(:algebraic_a8) { 'a8' }

      it 'returns an empty array' do
        result = dummy_class.top_left_diagonal_adjacent_coords(algebraic_a8)
        expect(result).to be_empty
      end
    end
  end

  describe '#top_right_diagonal_adjacent_coords' do
    context 'when passed algebraic coordinates "e4"' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns an array of top right diagonal adjacent coordinates' do
        result = dummy_class.top_right_diagonal_adjacent_coords(algebraic_e4)
        expect(result).to match_array(%w[h7 g6 f5])
      end
    end

    context 'when passed algebraic coordinates "c3"' do
      subject(:algebraic_c3) { 'c3' }

      it 'returns an array of top right diagonal adjacent coordinates' do
        result = dummy_class.top_right_diagonal_adjacent_coords(algebraic_c3)
        expect(result).to match_array(%w[h8 g7 f6 e5 d4])
      end
    end

    context 'when passed algebraic coordinates "h8"' do
      subject(:algebraic_h8) { 'h8' }

      it 'returns an empty array' do
        result = dummy_class.top_right_diagonal_adjacent_coords(algebraic_h8)
        expect(result).to be_empty
      end
    end
  end

  describe '#bottom_left_diagonal_adjacent_coords' do
    context 'when passed algebraic coordinates "e4"' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns an array of bottom left diagonal adjacent coordinates' do
        result = dummy_class.bottom_left_diagonal_adjacent_coords(algebraic_e4)
        expect(result).to match_array(%w[b1 c2 d3])
      end
    end

    context 'when passed algebraic coordinates "c3"' do
      subject(:algebraic_c3) { 'c3' }

      it 'returns an array of bottom left diagonal adjacent coordinates' do
        result = dummy_class.bottom_left_diagonal_adjacent_coords(algebraic_c3)
        expect(result).to match_array(%w[a1 b2])
      end
    end

    context 'when passed algebraic coordinates "a1"' do
      subject(:algebraic_a1) { 'a1' }

      it 'returns an empty array' do
        result = dummy_class.bottom_left_diagonal_adjacent_coords(algebraic_a1)
        expect(result).to be_empty
      end
    end
  end

  describe '#bottom_right_diagonal_adjacent_coords' do
    context 'when passed algebraic coordinates "e4"' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns an array of bottom right diagonal adjacent coordinates' do
        result = dummy_class.bottom_right_diagonal_adjacent_coords(algebraic_e4)
        expect(result).to match_array(%w[h1 g2 f3])
      end
    end

    context 'when passed algebraic coordinates "c3"' do
      subject(:algebraic_c3) { 'c3' }

      it 'returns an array of bottom right diagonal adjacent coordinates' do
        result = dummy_class.bottom_right_diagonal_adjacent_coords(algebraic_c3)
        expect(result).to match_array(%w[e1 d2])
      end
    end

    context 'when passed algebraic coordinates "h1"' do
      subject(:algebraic_h1) { 'h1' }

      it 'returns an empty array' do
        result = dummy_class.bottom_right_diagonal_adjacent_coords(algebraic_h1)
        expect(result).to be_empty
      end
    end
  end

  describe '#top_left_knight_adjacent_coords' do
    context 'when passed algebraic coordinates "e4"' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns an array of top left knight adjacent coordinates' do
        result = dummy_class.top_left_knight_adjacent_coords(algebraic_e4)
        expect(result).to match_array(%w[c5 d6])
      end
    end

    context 'when passed algebraic coordinates "b3"' do
      subject(:algebraic_b3) { 'b3' }

      it 'returns an array of top left knight adjacent coordinates' do
        result = dummy_class.top_left_knight_adjacent_coords(algebraic_b3)
        expect(result).to match_array(%w[a5])
      end
    end

    context 'when passed algebraic coordinates "a8"' do
      subject(:algebraic_a8) { 'a8' }

      it 'returns an empty array' do
        result = dummy_class.top_left_knight_adjacent_coords(algebraic_a8)
        expect(result).to be_empty
      end
    end
  end

  describe '#top_right_knight_adjacent_coords' do
    context 'when passed algebraic coordinates "e4"' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns an array of top right knight adjacent coordinates' do
        result = dummy_class.top_right_knight_adjacent_coords(algebraic_e4)
        expect(result).to match_array(%w[f6 g5])
      end
    end

    context 'when passed algebraic coordinates "g3"' do
      subject(:algebraic_g3) { 'g3' }

      it 'returns an array of top right knight adjacent coordinates' do
        result = dummy_class.top_right_knight_adjacent_coords(algebraic_g3)
        expect(result).to match_array(%w[h5])
      end
    end

    context 'when passed algebraic coordinates "h8"' do
      subject(:algebraic_h8) { 'h8' }

      it 'returns an empty array' do
        result = dummy_class.top_right_knight_adjacent_coords(algebraic_h8)
        expect(result).to be_empty
      end
    end
  end

  describe '#bottom_left_knight_adjacent_coords' do
    context 'when passed algebraic coordinates "e4"' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns an array of bottom left knight adjacent coordinates' do
        result = dummy_class.bottom_left_knight_adjacent_coords(algebraic_e4)
        expect(result).to match_array(%w[c3 d2])
      end
    end

    context 'when passed algebraic coordinates "b3"' do
      subject(:algebraic_b3) { 'b3' }

      it 'returns an array of bottom left knight adjacent coordinates' do
        result = dummy_class.bottom_left_knight_adjacent_coords(algebraic_b3)
        expect(result).to match_array(%w[a1])
      end
    end

    context 'when passed algebraic coordinates "a1"' do
      subject(:algebraic_a1) { 'a1' }

      it 'returns an empty array' do
        result = dummy_class.bottom_left_knight_adjacent_coords(algebraic_a1)
        expect(result).to be_empty
      end
    end
  end

  describe '#bottom_right_knight_adjacent_coords' do
    context 'when passed algebraic coordinates "e4"' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns an array of bottom right knight adjacent coordinates' do
        result = dummy_class.bottom_right_knight_adjacent_coords(algebraic_e4)
        expect(result).to match_array(%w[f2 g3])
      end
    end

    context 'when passed algebraic coordinates "g3"' do
      subject(:algebraic_g3) { 'g3' }

      it 'returns an array of bottom right knight adjacent coordinates' do
        result = dummy_class.bottom_right_knight_adjacent_coords(algebraic_g3)
        expect(result).to match_array(%w[h1])
      end
    end

    context 'when passed algebraic coordinates "h1"' do
      subject(:algebraic_h1) { 'h1' }

      it 'returns an empty array' do
        result = dummy_class.bottom_right_knight_adjacent_coords(algebraic_h1)
        expect(result).to be_empty
      end
    end
  end
end
