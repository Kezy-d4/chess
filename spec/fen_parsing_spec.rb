# frozen_string_literal: true

require_relative '../lib/fen_parsing'

describe FenParsing do
  let(:dummy_class) { Class.new { extend FenParsing } }
  let(:initial_fen) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' }

  describe '#data_fields' do
    context 'when the FEN record represents the initial chess position' do
      subject { initial_fen }

      it 'returns an array of substrings representing each data field' do
        result = dummy_class.data_fields(initial_fen)
        expected = ['rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR', 'w', 'KQkq', '-', '0', '1']
        expect(result).to eq(expected)
      end
    end
  end

  describe '#piece_placement_data' do
    context 'when the FEN record represents the initial chess position' do
      subject { initial_fen }

      it 'returns a substring representing the piece placement data field' do
        result = dummy_class.piece_placement_data(initial_fen)
        expected = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR'
        expect(result).to eq(expected)
      end
    end
  end

  describe '#active_color_data' do
    context 'when the FEN record represents the initial chess position' do
      subject { initial_fen }

      it 'returns a substring representing the active color data field' do
        result = dummy_class.active_color_data(initial_fen)
        expected = 'w'
        expect(result).to eq(expected)
      end
    end
  end

  describe '#castling_rights_data' do
    context 'when the FEN record represents the initial chess position' do
      subject { initial_fen }

      it 'returns a substring representing the castling rights data field' do
        result = dummy_class.castling_rights_data(initial_fen)
        expected = 'KQkq'
        expect(result).to eq(expected)
      end
    end
  end

  describe '#en_passant_target_square_data' do
    context 'when the FEN record represents the initial chess position' do
      subject { initial_fen }

      it 'returns a substring representing the en passant target square data field' do
        result = dummy_class.en_passant_target_square_data(initial_fen)
        expected = '-'
        expect(result).to eq(expected)
      end
    end
  end

  describe '#half_move_clock_data' do
    context 'when the FEN record represents the initial chess position' do
      subject { initial_fen }

      it 'returns a substring representing the half move clock data field' do
        result = dummy_class.half_move_clock_data(initial_fen)
        expected = '0'
        expect(result).to eq(expected)
      end
    end
  end

  describe '#full_move_number_data' do
    context 'when the FEN record represents the initial chess position' do
      subject { initial_fen }

      it 'returns a substring representing the full move number data field' do
        result = dummy_class.full_move_number_data(initial_fen)
        expected = '1'
        expect(result).to eq(expected)
      end
    end
  end

  describe '#piece_placement_data_of_ranks' do
    context 'when the FEN record represents the initial chess position' do
      subject { initial_fen }

      it 'returns an array of substrings representing the piece placement data of each rank' do
        result = dummy_class.piece_placement_data_of_ranks(initial_fen)
        expected = %w[rnbqkbnr pppppppp 8 8 8 8 PPPPPPPP RNBQKBNR]
        expect(result).to eq(expected)
      end
    end
  end

  describe '#piece_placement_data_by_rank' do
    context 'when the FEN record represents the initial chess position' do
      subject { initial_fen }

      it 'returns a substring representing the piece placement data of the eighth rank' do
        rank = 8
        result = dummy_class.piece_placement_data_by_rank(initial_fen, rank)
        expected = 'rnbqkbnr'
        expect(result).to eq(expected)
      end

      it 'returns a substring representing the piece placement data of the sixth rank' do
        rank = 6
        result = dummy_class.piece_placement_data_by_rank(initial_fen, rank)
        expected = '8'
        expect(result).to eq(expected)
      end

      it 'returns a substring representing the piece placement data of the third rank' do
        rank = 3
        result = dummy_class.piece_placement_data_by_rank(initial_fen, rank)
        expected = '8'
        expect(result).to eq(expected)
      end

      it 'returns a substring representing the piece placement data of the second rank' do
        rank = 2
        result = dummy_class.piece_placement_data_by_rank(initial_fen, rank)
        expected = 'PPPPPPPP'
        expect(result).to eq(expected)
      end
    end
  end

  describe '#fifty_move_rule_satisfied?' do
    context 'when the FEN record represents a chess position with at least one hundred half moves' do
      subject(:one_hundred_half_moves_fen) { '8/8/8/8/8/2N5/7k/5K2 w - - 100 151' }

      it 'returns true' do
        result = dummy_class.fifty_move_rule_satisfied?(one_hundred_half_moves_fen)
        expect(result).to be(true)
      end
    end

    context 'when the FEN record represents a chess position with more than one hundred half moves' do
      subject(:one_hundred_and_one_half_moves_fen) { '8/8/8/8/8/2N5/7k/5K2 w - - 101 151' }

      it 'returns true' do
        result = dummy_class.fifty_move_rule_satisfied?(one_hundred_and_one_half_moves_fen)
        expect(result).to be(true)
      end
    end

    context 'when the FEN record represents a chess position with less than one hundred half moves' do
      subject(:ninety_nine_half_moves_fen) { '8/8/8/8/8/2N5/7k/5K2 w - - 99 151' }

      it 'returns false' do
        result = dummy_class.fifty_move_rule_satisfied?(ninety_nine_half_moves_fen)
        expect(result).to be(false)
      end
    end
  end

  describe '#seventy_five_move_rule_satisfied?' do
    context 'when the FEN record represents a chess position with at least one hundred and fifty half moves' do
      subject(:one_hundred_and_fifty_half_moves_fen) { '8/8/8/8/8/2N5/7k/5K2 w - - 150 201' }

      it 'returns true' do
        result = dummy_class.seventy_five_move_rule_satisfied?(one_hundred_and_fifty_half_moves_fen)
        expect(result).to be(true)
      end
    end

    context 'when the FEN record represents a chess position with more than one hundred and fifty half moves' do
      subject(:one_hundred_and_fifty_one_half_moves_fen) { '8/8/8/8/8/2N5/7k/5K2 w - - 151 201' }

      it 'returns true' do
        result = dummy_class.seventy_five_move_rule_satisfied?(one_hundred_and_fifty_one_half_moves_fen)
        expect(result).to be(true)
      end
    end

    context 'when the FEN record represents a chess position with less than one hundred and fifty half moves' do
      subject(:one_hundred_and_forty_nine_half_moves_fen) { '8/8/8/8/8/2N5/7k/5K2 w - - 149 201' }

      it 'returns false' do
        result = dummy_class.seventy_five_move_rule_satisfied?(one_hundred_and_forty_nine_half_moves_fen)
        expect(result).to be(false)
      end
    end
  end

  describe '#en_passant_target_square_available?' do
    context 'when the FEN record represents a chess position with an en passant target square' do
      subject(:en_passant_target_fen) { 'rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1' }

      it 'returns true' do
        result = dummy_class.en_passant_target_square_available?(en_passant_target_fen)
        expect(result).to be(true)
      end
    end

    context 'when the FEN record represents a chess position without an en passant target square' do
      subject { initial_fen }

      it 'returns false' do
        result = dummy_class.en_passant_target_square_available?(initial_fen)
        expect(result).to be(false)
      end
    end
  end

  describe '#white_kingside_castle_available?' do
    context 'when the FEN record represents a chess position where White has kingside castling rights' do
      subject { initial_fen }

      it 'returns true' do
        result = dummy_class.white_kingside_castle_available?(initial_fen)
        expect(result).to be(true)
      end
    end

    context 'when the FEN record represents a chess position where White does not have kingside castling rights' do
      subject(:white_kingside_castle_unavailable_fen) { '8/8/8/8/8/2N5/7k/5K2 w - - 99 151' }

      it 'returns false' do
        result = dummy_class.white_kingside_castle_available?(white_kingside_castle_unavailable_fen)
        expect(result).to be(false)
      end
    end
  end

  describe '#white_queenside_castle_available?' do
    context 'when the FEN record represents a chess position where White has queenside castling rights' do
      subject { initial_fen }

      it 'returns true' do
        result = dummy_class.white_queenside_castle_available?(initial_fen)
        expect(result).to be(true)
      end
    end

    context 'when the FEN record represents a chess position where White does not have queenside castling rights' do
      subject(:white_queenside_castle_unavailable_fen) { '8/8/8/8/8/2N5/7k/5K2 w - - 99 151' }

      it 'returns false' do
        result = dummy_class.white_queenside_castle_available?(white_queenside_castle_unavailable_fen)
        expect(result).to be(false)
      end
    end
  end

  describe '#black_kingside_castle_available?' do
    context 'when the FEN record represents a chess position where Black has kingside castling rights' do
      subject { initial_fen }

      it 'returns true' do
        result = dummy_class.black_kingside_castle_available?(initial_fen)
        expect(result).to be(true)
      end
    end

    context 'when the FEN record represents a chess position where Black does not have kingside castling rights' do
      subject(:black_kingside_castle_unavailable_fen) { '8/8/8/8/8/2N5/7k/5K2 w - - 99 151' }

      it 'returns false' do
        result = dummy_class.black_kingside_castle_available?(black_kingside_castle_unavailable_fen)
        expect(result).to be(false)
      end
    end
  end

  describe '#black_queenside_castle_available?' do
    context 'when the FEN record represents a chess position where Black has queenside castling rights' do
      subject { initial_fen }

      it 'returns true' do
        result = dummy_class.black_queenside_castle_available?(initial_fen)
        expect(result).to be(true)
      end
    end

    context 'when the FEN record represents a chess position where Black does not have queenside castling rights' do
      subject(:black_queenside_castle_unavailable_fen) { '8/8/8/8/8/2N5/7k/5K2 w - - 99 151' }

      it 'returns false' do
        result = dummy_class.black_queenside_castle_available?(black_queenside_castle_unavailable_fen)
        expect(result).to be(false)
      end
    end
  end
end
