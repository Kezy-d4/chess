# frozen_string_literal: true

describe Chess::Position do
  describe '::from_fen_parser' do
    subject { described_class }

    context 'when passed a default FENParser' do
      it 'returns a Position based on the FENParser' do
        fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
        result = described_class.from_fen_parser(fen_parser_default)
        converted_fen = result.to_fen
        expect(converted_fen).to eq(Chess::ChessConstants::FEN_DEFAULT)
      end
    end
  end

  describe '#to_fen' do
    context 'when testing a default Position' do
      subject(:position_default) do
        fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
        described_class.from_fen_parser(fen_parser_default)
      end

      it 'returns a FEN record based on the Position' do
        result = position_default.to_fen
        expect(result).to eq(Chess::ChessConstants::FEN_DEFAULT)
      end
    end

    context 'when testing a Position of the immortal game after 11.Rg1' do
      subject(:position_mid) do
        fen_parser_immortal = Chess::FENParser.new(fen_immortal)
        described_class.from_fen_parser(fen_parser_immortal)
      end

      let(:fen_immortal) { 'rnb1kb1r/p2p1ppp/2p2n2/1B3Nq1/4PpP1/3P4/PPP4P/RNBQ1KR1 b kq - 2 11' }

      it 'returns a FEN record based on the Position' do
        result = position_mid.to_fen
        expect(result).to eq(fen_immortal)
      end
    end
  end

  describe '#move' do
    subject(:position_mid) do
      fen_immortal = 'rnb1kb1r/p2p1ppp/2p2n2/1B3Nq1/4PpP1/3P4/PPP4P/RNBQ1KR1 b kq - 2 11'
      fen_parser_immortal = Chess::FENParser.new(fen_immortal)
      described_class.from_fen_parser(fen_parser_immortal)
    end

    context 'when the destination is occupied' do
      let(:source_coord) { Chess::Coord.from_s('f6') }
      let(:destination_coord) { Chess::Coord.from_s('e4') }
      let(:piece_placement_before) { 'rnb1kb1r/p2p1ppp/2p2n2/1B3Nq1/4PpP1/3P4/PPP4P/RNBQ1KR1' }
      let(:piece_placement_after) { 'rnb1kb1r/p2p1ppp/2p5/1B3Nq1/4npP1/3P4/PPP4P/RNBQ1KR1' }

      it 'moves the source Piece, capturing the Piece at the destination' do
        expect { position_mid.move(source_coord, destination_coord) }
          .to change { position_mid.to_fen.split[0] }
          .from(piece_placement_before).to(piece_placement_after)
      end
    end

    context 'when the destination is unoccupied' do
      let(:source_coord) { Chess::Coord.from_s('f6') }
      let(:destination_coord) { Chess::Coord.from_s('g8') }
      let(:piece_placement_before) { 'rnb1kb1r/p2p1ppp/2p2n2/1B3Nq1/4PpP1/3P4/PPP4P/RNBQ1KR1' }
      let(:piece_placement_after) { 'rnb1kbnr/p2p1ppp/2p5/1B3Nq1/4PpP1/3P4/PPP4P/RNBQ1KR1' }

      it 'moves the source Piece to the destination' do
        expect { position_mid.move(source_coord, destination_coord) }
          .to change { position_mid.to_fen.split[0] }
          .from(piece_placement_before).to(piece_placement_after)
      end
    end
  end

  describe '#check?' do
    context 'when testing a Position of the immortal game after 3...Qh4+' do
      subject(:position_check) do
        fen_immortal = 'rnb1kbnr/pppp1ppp/8/8/2B1Pp1q/8/PPPP2PP/RNBQK1NR w KQkq - 2 4'
        fen_parser_immortal = Chess::FENParser.new(fen_immortal)
        described_class.from_fen_parser(fen_parser_immortal)
      end

      it 'returns true' do
        result = position_check.check?
        expect(result).to be(true)
      end
    end

    context 'when testing a Position of the immortal game after 19...Qxa1+' do
      subject(:position_check) do
        fen_immortal = 'rnb1k1nr/p2p1ppp/3B4/1p1NPN1P/6P1/3P1Q2/P1P5/q4Kb1 w kq - 0 20'
        fen_parser_immortal = Chess::FENParser.new(fen_immortal)
        described_class.from_fen_parser(fen_parser_immortal)
      end

      it 'returns true' do
        result = position_check.check?
        expect(result).to be(true)
      end
    end

    context 'when testing a Position of the immortal game after 21.Nxg7+' do
      subject(:position_check) do
        fen_immortal = 'r1b1k1nr/p2p1pNp/n2B4/1p1NP2P/6P1/3P1Q2/P1P1K3/q5b1 b kq - 0 21'
        fen_parser_immortal = Chess::FENParser.new(fen_immortal)
        described_class.from_fen_parser(fen_parser_immortal)
      end

      it 'returns true' do
        result = position_check.check?
        expect(result).to be(true)
      end
    end

    context 'when testing a Position of the immortal game after 22.Qf6+' do
      subject(:position_check) do
        fen_immortal = 'r1bk2nr/p2p1pNp/n2B1Q2/1p1NP2P/6P1/3P4/P1P1K3/q5b1 b - - 2 22'
        fen_parser_immortal = Chess::FENParser.new(fen_immortal)
        described_class.from_fen_parser(fen_parser_immortal)
      end

      it 'returns true' do
        result = position_check.check?
        expect(result).to be(true)
      end
    end

    context 'when testing a Position of the immortal game after 23.Be7#1-0' do
      subject(:position_check) do
        fen_immortal = 'r1bk3r/p2pBpNp/n4n2/1p1NP2P/6P1/3P4/P1P1K3/q5b1 b - - 1 23'
        fen_parser_immortal = Chess::FENParser.new(fen_immortal)
        described_class.from_fen_parser(fen_parser_immortal)
      end

      it 'returns true' do
        result = position_check.check?
        expect(result).to be(true)
      end
    end

    context 'when testing a Position of the immortal game after 2...exf4' do
      subject(:position_no_check) do
        fen_immortal = 'rnbqkbnr/pppp1ppp/8/8/4Pp2/8/PPPP2PP/RNBQKBNR w KQkq - 0 3'
        fen_parser_immortal = Chess::FENParser.new(fen_immortal)
        described_class.from_fen_parser(fen_parser_immortal)
      end

      it 'returns false' do
        result = position_no_check.check?
        expect(result).to be(false)
      end
    end

    context 'when testing a Position of the immortal game after 4.Kf1' do
      subject(:position_no_check) do
        fen_immortal = 'rnb1kbnr/pppp1ppp/8/8/2B1Pp1q/8/PPPP2PP/RNBQ1KNR b kq - 3 4'
        fen_parser_immortal = Chess::FENParser.new(fen_immortal)
        described_class.from_fen_parser(fen_parser_immortal)
      end

      it 'returns false' do
        result = position_no_check.check?
        expect(result).to be(false)
      end
    end
  end

  describe '#checkmate?' do
    context 'when testing a Position of the immortal game after 23.Be7#1-0' do
      subject(:position_checkmate) do
        fen_immortal = 'r1bk3r/p2pBpNp/n4n2/1p1NP2P/6P1/3P4/P1P1K3/q5b1 b - - 1 23'
        fen_parser_immortal = Chess::FENParser.new(fen_immortal)
        described_class.from_fen_parser(fen_parser_immortal)
      end

      it 'returns true' do
        result = position_checkmate.checkmate?
        expect(result).to be(true)
      end
    end

    context 'when testing a Position of the fool\'s mate after 2...Qh4#0-1' do
      subject(:position_checkmate) do
        fen_fool = 'rnb1kbnr/pppp1ppp/8/4p3/6Pq/5P2/PPPPP2P/RNBQKBNR w KQkq - 1 3'
        fen_parser_fool = Chess::FENParser.new(fen_fool)
        described_class.from_fen_parser(fen_parser_fool)
      end

      it 'returns true' do
        result = position_checkmate.checkmate?
        expect(result).to be(true)
      end
    end

    context 'when testing a Position of the opera game after 17.Rd8#1-0' do
      subject(:position_checkmate) do
        fen_opera = '1n1Rkb1r/p4ppp/4q3/4p1B1/4P3/8/PPP2PPP/2K5 b k - 1 17'
        fen_parser_opera = Chess::FENParser.new(fen_opera)
        described_class.from_fen_parser(fen_parser_opera)
      end

      it 'returns true' do
        result = position_checkmate.checkmate?
        expect(result).to be(true)
      end
    end

    context 'when testing a Position of the immortal game after 3...Qh4+' do
      subject(:position_no_checkmate) do
        fen_immortal = 'rnb1kbnr/pppp1ppp/8/8/2B1Pp1q/8/PPPP2PP/RNBQK1NR w KQkq - 2 4'
        fen_parser_immortal = Chess::FENParser.new(fen_immortal)
        described_class.from_fen_parser(fen_parser_immortal)
      end

      it 'returns false' do
        result = position_no_checkmate.checkmate?
        expect(result).to be(false)
      end
    end

    context 'when testing a Position of the immortal game after 21.Nxg7+' do
      subject(:position_no_checkmate) do
        fen_immortal = 'r1b1k1nr/p2p1pNp/n2B4/1p1NP2P/6P1/3P1Q2/P1P1K3/q5b1 b kq - 0 21'
        fen_parser_immortal = Chess::FENParser.new(fen_immortal)
        described_class.from_fen_parser(fen_parser_immortal)
      end

      it 'returns false' do
        result = position_no_checkmate.checkmate?
        expect(result).to be(false)
      end
    end

    context 'when testing a Position of the immortal game after 3.Bc4' do
      subject(:position_no_checkmate) do
        fen_immortal = 'rnbqkbnr/pppp1ppp/8/8/2B1Pp2/8/PPPP2PP/RNBQK1NR b KQkq - 1 3'
        fen_parser_immortal = Chess::FENParser.new(fen_immortal)
        described_class.from_fen_parser(fen_parser_immortal)
      end

      it 'returns false' do
        result = position_no_checkmate.checkmate?
        expect(result).to be(false)
      end
    end
  end

  describe '#stalemate?' do
    context 'when testing a Position of Jens vs Tena after 12...e3 1/2-1/2' do
      subject(:position_stalemate) do
        fen_stalemate = 'rn2k1nr/pp4pp/3p4/b1pP4/P1P2p1q/1b2pPRP/1P1NP1PQ/2B1KBNR w Kkq - 0 13'
        fen_parser_stalemate = Chess::FENParser.new(fen_stalemate)
        described_class.from_fen_parser(fen_parser_stalemate)
      end

      it 'returns true' do
        result = position_stalemate.stalemate?
        expect(result).to be(true)
      end
    end

    context 'when testing a Position of Anand vs Kramnik after 65...Kxf5 1/2-1/2' do
      subject(:position_stalemate) do
        fen_stalemate = '8/6p1/5p2/5k1K/7P/8/8/8 w - - 0 66'
        fen_parser_stalemate = Chess::FENParser.new(fen_stalemate)
        described_class.from_fen_parser(fen_parser_stalemate)
      end

      it 'returns true' do
        result = position_stalemate.stalemate?
        expect(result).to be(true)
      end
    end

    context 'when testing a Position of Korchnoi vs. Karpov after 124.Bg7 1/2-1/2' do
      subject(:position_stalemate) do
        fen_stalemate = '8/5KBk/8/8/p7/P7/8/8 b - - 0 124'
        fen_parser_stalemate = Chess::FENParser.new(fen_stalemate)
        described_class.from_fen_parser(fen_parser_stalemate)
      end

      it 'returns true' do
        result = position_stalemate.stalemate?
        expect(result).to be(true)
      end
    end

    context 'when testing a Position of fool\'s mate after 2...Qh4#0-1' do
      subject(:position_no_stalemate) do
        fen_no_stalemate = 'rnb1kbnr/pppp1ppp/4p3/8/6Pq/5P2/PPPPP2P/RNBQKBNR w KQkq - 1 3'
        fen_parser_no_stalemate = Chess::FENParser.new(fen_no_stalemate)
        described_class.from_fen_parser(fen_parser_no_stalemate)
      end

      it 'returns false' do
        result = position_no_stalemate.stalemate?
        expect(result).to be(false)
      end
    end

    context 'when testing a Position of the immortal game after 3...Qh4+' do
      subject(:position_no_stalemate) do
        fen_no_stalemate = 'rnb1kbnr/pppp1ppp/8/8/2B1Pp1q/8/PPPP2PP/RNBQK1NR w KQkq - 2 4'
        fen_parser_no_stalemate = Chess::FENParser.new(fen_no_stalemate)
        described_class.from_fen_parser(fen_parser_no_stalemate)
      end

      it 'returns false' do
        result = position_no_stalemate.stalemate?
        expect(result).to be(false)
      end
    end

    context 'when testing a Position of the immortal game after 2...exf4' do
      subject(:position_no_stalemate) do
        fen_no_stalemate = 'rnbqkbnr/pppp1ppp/8/8/4Pp2/8/PPPP2PP/RNBQKBNR w KQkq - 0 3'
        fen_parser_no_stalemate = Chess::FENParser.new(fen_no_stalemate)
        described_class.from_fen_parser(fen_parser_no_stalemate)
      end

      it 'returns false' do
        result = position_no_stalemate.stalemate?
        expect(result).to be(false)
      end
    end
  end

  describe '#draw_by_fifty_move_rule_claimable?' do
    subject(:position_default) do
      fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
      described_class.from_fen_parser(fen_parser_default)
    end

    let(:aux_pos_data) { position_default.instance_variable_get(:@aux_pos_data) }

    before { allow(aux_pos_data).to receive(:fifty_move_rule_satisfied?) }

    it 'sends #fifty_move_rule_satisfied? to the AuxPosData' do
      position_default.draw_by_fifty_move_rule_claimable?
      expect(aux_pos_data).to have_received(:fifty_move_rule_satisfied?)
    end
  end

  describe '#draw_by_seventy_five_move_rule?' do
    subject(:position_default) do
      fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
      described_class.from_fen_parser(fen_parser_default)
    end

    let(:aux_pos_data) { position_default.instance_variable_get(:@aux_pos_data) }

    before { allow(aux_pos_data).to receive(:seventy_five_move_rule_satisfied?) }

    it 'sends #seventy_five_move_rule_satisfied? to the AuxPosData' do
      position_default.draw_by_seventy_five_move_rule?
      expect(aux_pos_data).to have_received(:seventy_five_move_rule_satisfied?)
    end
  end

  describe '#over?' do
    context 'when checkmate' do
      subject(:position_checkmate) do
        fen_checkmate = 'rnb1kbnr/pppp1ppp/4p3/8/6Pq/5P2/PPPPP2P/RNBQKBNR w KQkq - 1 3'
        fen_parser_checkmate = Chess::FENParser.new(fen_checkmate)
        described_class.from_fen_parser(fen_parser_checkmate)
      end

      it 'returns true' do
        result = position_checkmate.over?
        expect(result).to be(true)
      end
    end

    context 'when stalemate' do
      subject(:position_stalemate) do
        fen_stalemate = 'rn2k1nr/pp4pp/3p4/b1pP4/P1P2p1q/1b2pPRP/1P1NP1PQ/2B1KBNR w Kkq - 0 13'
        fen_parser_stalemate = Chess::FENParser.new(fen_stalemate)
        described_class.from_fen_parser(fen_parser_stalemate)
      end

      it 'returns true' do
        result = position_stalemate.over?
        expect(result).to be(true)
      end
    end

    context 'when draw by seventy five move rule' do
      subject(:position_draw_by_seventy_five_move_rule) do
        fen_seventy_five = 'rnbqkbnr/pppppppp/8/8/8/5N2/PPPPPPPP/RNBQKB1R b KQkq - 150 75'
        fen_parser_seventy_five = Chess::FENParser.new(fen_seventy_five)
        described_class.from_fen_parser(fen_parser_seventy_five)
      end

      it 'returns true' do
        result = position_draw_by_seventy_five_move_rule.over?
        expect(result).to be(true)
      end
    end

    context 'when not over' do
      subject(:position_not_over) do
        fen_not_over = Chess::ChessConstants::FEN_DEFAULT
        fen_parser_not_over = Chess::FENParser.new(fen_not_over)
        described_class.from_fen_parser(fen_parser_not_over)
      end

      it 'returns false' do
        result = position_not_over.over?
        expect(result).to be(false)
      end
    end
  end

  describe '#legal_move?' do
    context 'when testing a Position of the immortal game after 22.Qf6+' do
      subject(:position_check) do
        fen_immortal = 'r1bk2nr/p2p1pNp/n2B1Q2/1p1NP2P/6P1/3P4/P1P1K3/q5b1 b - - 1 22'
        fen_parser_immortal = Chess::FENParser.new(fen_immortal)
        described_class.from_fen_parser(fen_parser_immortal)
      end

      specify 'Coord g8 to e7 returns true' do
        result = position_check.legal_move?(Chess::Coord.from_s('g8'), Chess::Coord.from_s('e7'))
        expect(result).to be(true)
      end

      specify 'Coord g8 to f6 returns true' do
        result = position_check.legal_move?(Chess::Coord.from_s('g8'), Chess::Coord.from_s('f6'))
        expect(result).to be(true)
      end

      specify 'Coord d8 to e7 returns false' do
        result = position_check.legal_move?(Chess::Coord.from_s('d8'), Chess::Coord.from_s('e7'))
        expect(result).to be(false)
      end

      specify 'Coord a1 to d1 returns false' do
        result = position_check.legal_move?(Chess::Coord.from_s('a1'), Chess::Coord.from_s('d1'))
        expect(result).to be(false)
      end
    end

    context 'when testing a Position of the immortal game after 3...Qh4+' do
      subject(:position_check) do
        fen_immortal = 'rnb1kbnr/pppp1ppp/8/8/2B1Pp1q/8/PPPP2PP/RNBQK1NR w KQkq - 2 4'
        fen_parser_immortal = Chess::FENParser.new(fen_immortal)
        described_class.from_fen_parser(fen_parser_immortal)
      end

      specify 'Coord e1 to f1 returns true' do
        result = position_check.legal_move?(Chess::Coord.from_s('e1'), Chess::Coord.from_s('f1'))
        expect(result).to be(true)
      end

      specify 'Coord g2 to g3 returns true' do
        result = position_check.legal_move?(Chess::Coord.from_s('g2'), Chess::Coord.from_s('g3'))
        expect(result).to be(true)
      end

      specify 'Coord d1 to f3 returns false' do
        result = position_check.legal_move?(Chess::Coord.from_s('d1'), Chess::Coord.from_s('f3'))
        expect(result).to be(false)
      end

      specify 'Coord e1 to f2 returns false' do
        result = position_check.legal_move?(Chess::Coord.from_s('e1'), Chess::Coord.from_s('f2'))
        expect(result).to be(false)
      end
    end

    context 'when testing a Position of the immortal game after 5.Bxb5' do
      subject(:position_pinned) do
        fen_immortal = 'rnb1kbnr/p1pp1ppp/8/1B6/4Pp1q/8/PPPP2PP/RNBQ1KNR b kq - 0 5'
        fen_parser_immortal = Chess::FENParser.new(fen_immortal)
        described_class.from_fen_parser(fen_parser_immortal)
      end

      specify 'Coord d7 to d6 returns false' do
        result = position_pinned.legal_move?(Chess::Coord.from_s('d7'), Chess::Coord.from_s('d6'))
        expect(result).to be(false)
      end

      specify 'Coord g8 to f6 returns true' do
        result = position_pinned.legal_move?(Chess::Coord.from_s('g8'), Chess::Coord.from_s('f6'))
        expect(result).to be(true)
      end
    end

    context 'when testing the starting Position' do
      subject(:position_default) do
        fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
        described_class.from_fen_parser(fen_parser_default)
      end

      specify 'Coord e7 to e5 returns false' do
        result = position_default.legal_move?(Chess::Coord.from_s('e7'), Chess::Coord.from_s('e5'))
        expect(result).to be(false)
      end

      specify 'Coord e2 to f3 returns false' do
        result = position_default.legal_move?(Chess::Coord.from_s('e2'), Chess::Coord.from_s('f3'))
        expect(result).to be(false)
      end

      specify 'Coord e2 to e5 returns false' do
        result = position_default.legal_move?(Chess::Coord.from_s('e2'), Chess::Coord.from_s('e5'))
        expect(result).to be(false)
      end

      specify 'Coord d1 to d2 returns false' do
        result = position_default.legal_move?(Chess::Coord.from_s('d1'), Chess::Coord.from_s('d2'))
        expect(result).to be(false)
      end

      specify 'Coord d1 to d3 returns false' do
        result = position_default.legal_move?(Chess::Coord.from_s('d1'), Chess::Coord.from_s('d3'))
        expect(result).to be(false)
      end

      specify 'Coord e2 to e4 returns true' do
        result = position_default.legal_move?(Chess::Coord.from_s('e2'), Chess::Coord.from_s('e4'))
        expect(result).to be(true)
      end
    end
  end

  describe '#to_legal_destinations_from' do
    context 'when testing the starting Position' do
      subject(:position_default) do
        fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
        described_class.from_fen_parser(fen_parser_default)
      end

      specify 'Coord e4 returns an empty array' do
        result = position_default.to_legal_destinations_from(Chess::Coord.from_s('e4'))
        expect(result).to be_an(Array).and be_empty
      end

      specify 'Coord e7 returns an empty array' do
        result = position_default.to_legal_destinations_from(Chess::Coord.from_s('e7'))
        expect(result).to be_an(Array).and be_empty
      end

      specify 'Coord b1 returns the expected array' do
        expected = %w[a3 c3].map { |coord_s| Chess::Coord.from_s(coord_s) }
        result = position_default.to_legal_destinations_from(Chess::Coord.from_s('b1'))
        expect(result).to match_array(expected)
      end
    end

    context 'when testing a Position of the immortal game after 5.Bxb5' do
      subject(:position_pinned) do
        fen_immortal = 'rnb1kbnr/p1pp1ppp/8/1B6/4Pp1q/8/PPPP2PP/RNBQ1KNR b kq - 0 5'
        fen_parser_immortal = Chess::FENParser.new(fen_immortal)
        described_class.from_fen_parser(fen_parser_immortal)
      end

      specify 'Coord d7 returns an empty array' do
        result = position_pinned.to_legal_destinations_from(Chess::Coord.from_s('d7'))
        expect(result).to be_an(Array).and be_empty
      end

      specify 'Coord h4 returns the expected array' do
        expected = %w[h3 h2 g3 f2 e1 g4 g5 f6 e7 d8 h5 h6].map { |coord_s| Chess::Coord.from_s(coord_s) }
        result = position_pinned.to_legal_destinations_from(Chess::Coord.from_s('h4'))
        expect(result).to match_array(expected)
      end
    end
  end

  describe '#legal_source?' do
    context 'when testing the default Position' do
      subject(:position_default) do
        fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
        described_class.from_fen_parser(fen_parser_default)
      end

      let(:valid_coords) do
        %w[
          a1 b1 c1 d1 e1 f1 g1 h1
          a2 b2 c2 d2 e2 f2 g2 h2
        ].map { |coord_s| Chess::Coord.from_s(coord_s) }
      end
      let(:invalid_coords) do
        %w[
          a3 b3 c3 d3 e3 f3 g3 h3
          a4 b4 c4 d4 e4 f4 g4 h4
          a5 b5 c5 d5 e5 f5 g5 h5
          a6 b6 c6 d6 e6 f6 g6 h6
          a7 b7 c7 d7 e7 f7 g7 h7
          a8 b8 c8 d8 e8 f8 g8 h8
        ].map { |coord_s| Chess::Coord.from_s(coord_s) }
      end

      it 'returns true when passed any valid Coord' do
        result = valid_coords.all? { |coord| position_default.legal_source?(coord) }
        expect(result).to be(true)
      end

      it 'returns false when passed any invalid Coord' do
        result = invalid_coords.none? { |coord| position_default.legal_source?(coord) }
        expect(result).to be(true)
      end
    end
  end

  describe '#deselect_source' do
    subject(:position_default) do
      fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
      described_class.from_fen_parser(fen_parser_default)
    end

    let(:log) { position_default.instance_variable_get(:@log) }

    before do
      allow(log).to receive(:reset_metadata).with(
        :current_source, :currently_controlled, :currently_attacked
      )
    end

    it 'sends #reset_metadata to the Log with expected args' do
      position_default.deselect_source
      expect(log).to have_received(:reset_metadata).with(
        :current_source, :currently_controlled, :currently_attacked
      )
    end
  end

  describe '#to_active_player' do
    context 'when white is active' do
      subject(:position_white_active) do
        fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
        described_class.from_fen_parser(fen_parser_default)
      end

      it 'returns the Player playing white' do
        result = position_white_active.to_active_player
        expect(result).to be(position_white_active.instance_variable_get(:@player_white))
      end
    end

    context 'when black is active' do
      subject(:position_black_active) do
        fen_black_active = 'rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1'
        fen_parser_black_active = Chess::FENParser.new(fen_black_active)
        described_class.from_fen_parser(fen_parser_black_active)
      end

      it 'returns the Player playing black' do
        result = position_black_active.to_active_player
        expect(result).to be(position_black_active.instance_variable_get(:@player_black))
      end
    end
  end

  describe '#to_inactive_player' do
    context 'when white is active' do
      subject(:position_white_active) do
        fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
        described_class.from_fen_parser(fen_parser_default)
      end

      it 'returns the Player playing black' do
        result = position_white_active.to_inactive_player
        expect(result).to be(position_white_active.instance_variable_get(:@player_black))
      end
    end

    context 'when black is active' do
      subject(:position_black_active) do
        fen_black_active = 'rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1'
        fen_parser_black_active = Chess::FENParser.new(fen_black_active)
        described_class.from_fen_parser(fen_parser_black_active)
      end

      it 'returns the Player playing white' do
        result = position_black_active.to_inactive_player
        expect(result).to be(position_black_active.instance_variable_get(:@player_white))
      end
    end
  end

  describe '#swap_active_player' do
    context 'when white is active and swapping to a non-checked black' do
      subject(:position_white_to_non_checked_black) do
        fen_white_active = 'rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR w KQkq e3 0 1'
        fen_parser_white_active = Chess::FENParser.new(fen_white_active)
        described_class.from_fen_parser(fen_parser_white_active)
      end

      let(:log) { position_white_to_non_checked_black.instance_variable_get(:@log) }

      before { allow(log).to receive(:reset_metadata).with(:checked_king) }

      it 'does not increment the full move number and swaps the active color' do
        position_white_to_non_checked_black.swap_active_player
        fen_after = position_white_to_non_checked_black.to_fen
        expect(fen_after).to eq('rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1')
      end

      it 'sends #reset_metadata to the Log with expected args' do
        position_white_to_non_checked_black.swap_active_player
        expect(log).to have_received(:reset_metadata).with(:checked_king)
      end
    end

    context 'when white is active and swapping to a checked black' do
      subject(:position_white_to_checked_black) do
        fen_white_active = 'r1b1k1nr/p2p1pNp/n2B4/1p1NP2P/6P1/3P1Q2/P1P1K3/q5b1 w kq - 0 21'
        fen_parser_white_active = Chess::FENParser.new(fen_white_active)
        described_class.from_fen_parser(fen_parser_white_active)
      end

      let(:log) { position_white_to_checked_black.instance_variable_get(:@log) }
      let(:checked_king_coord) { Chess::Coord.from_s('e8') }

      before { allow(log).to receive(:update_metadata).with([:checked_king, checked_king_coord]) }

      it 'does not increment the full move number and swaps the active color' do
        position_white_to_checked_black.swap_active_player
        fen_after = position_white_to_checked_black.to_fen
        expect(fen_after).to eq('r1b1k1nr/p2p1pNp/n2B4/1p1NP2P/6P1/3P1Q2/P1P1K3/q5b1 b kq - 0 21')
      end

      it 'sends #update_metadata to the Log with expected args' do
        position_white_to_checked_black.swap_active_player
        expect(log).to have_received(:update_metadata).with([:checked_king, checked_king_coord])
      end
    end

    context 'when black is active and swapping to a non-checked white' do
      subject(:position_black_to_non_checked_white) do
        fen_black_active = 'rnbqkbnr/pppp1ppp/8/4p3/4P3/8/PPPP1PPP/RNBQKBNR b KQkq - 0 1'
        fen_parser_black_active = Chess::FENParser.new(fen_black_active)
        described_class.from_fen_parser(fen_parser_black_active)
      end

      let(:log) { position_black_to_non_checked_white.instance_variable_get(:@log) }

      before { allow(log).to receive(:reset_metadata).with(:checked_king) }

      it 'increments the full move number and swaps the active color' do
        position_black_to_non_checked_white.swap_active_player
        fen_after = position_black_to_non_checked_white.to_fen
        expect(fen_after).to eq('rnbqkbnr/pppp1ppp/8/4p3/4P3/8/PPPP1PPP/RNBQKBNR w KQkq - 0 2')
      end

      it 'sends #reset_metadata to the Log with expected args' do
        position_black_to_non_checked_white.swap_active_player
        expect(log).to have_received(:reset_metadata).with(:checked_king)
      end
    end

    context 'when black is active and swapping to a checked white' do
      subject(:position_black_to_checked_white) do
        fen_black_active = 'rnb1kbnr/pppp1ppp/8/8/2B1Pp1q/8/PPPP2PP/RNBQK1NR b KQkq - 2 3'
        fen_parser_black_active = Chess::FENParser.new(fen_black_active)
        described_class.from_fen_parser(fen_parser_black_active)
      end

      let(:log) { position_black_to_checked_white.instance_variable_get(:@log) }
      let(:checked_king_coord) { Chess::Coord.from_s('e1') }

      before { allow(log).to receive(:update_metadata).with([:checked_king, checked_king_coord]) }

      it 'increments the full move number and swaps the active color' do
        position_black_to_checked_white.swap_active_player
        fen_after = position_black_to_checked_white.to_fen
        expect(fen_after).to eq('rnb1kbnr/pppp1ppp/8/8/2B1Pp1q/8/PPPP2PP/RNBQK1NR w KQkq - 2 4')
      end

      it 'sends #update_metadata to the Log with expected args' do
        position_black_to_checked_white.swap_active_player
        expect(log).to have_received(:update_metadata).with([:checked_king, checked_king_coord])
      end
    end
  end

  describe '#to_player_sources' do
    subject(:position_default) do
      fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
      described_class.from_fen_parser(fen_parser_default)
    end

    context 'when passed the Player playing white' do
      let(:expected) do
        %w[
          a1 b1 c1 d1 e1 f1 g1 h1
          a2 b2 c2 d2 e2 f2 g2 h2
        ].map { |coord_s| Chess::Coord.from_s(coord_s) }
      end

      it 'returns an array of the white source Coords' do
        result = position_default.to_player_sources(position_default.to_active_player)
        expect(result).to match_array(expected)
      end
    end

    context 'when passed the Player playing black' do
      let(:expected) do
        %w[
          a8 b8 c8 d8 e8 f8 g8 h8
          a7 b7 c7 d7 e7 f7 g7 h7
        ].map { |coord_s| Chess::Coord.from_s(coord_s) }
      end

      it 'returns an array of the black source Coords' do
        result = position_default.to_player_sources(position_default.to_inactive_player)
        expect(result).to match_array(expected)
      end
    end
  end

  describe '#to_board_ranks' do
    subject(:position_default) do
      fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
      described_class.from_fen_parser(fen_parser_default)
    end

    let(:board) { position_default.instance_variable_get(:@board) }

    before { allow(board).to receive(:to_ranks) }

    it 'sends #to_ranks to the Board' do
      position_default.to_board_ranks
      expect(board).to have_received(:to_ranks)
    end
  end

  describe '#dump_log' do
    subject(:position_default) do
      fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
      described_class.from_fen_parser(fen_parser_default)
    end

    let(:log) { position_default.instance_variable_get(:@log) }

    before { allow(log).to receive(:dump) }

    it 'sends #dump to the Log' do
      position_default.dump_log
      expect(log).to have_received(:dump)
    end
  end

  describe '#to_s' do
    context 'when testing a default Position' do
      subject(:position_default) do
        fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
        described_class.from_fen_parser(fen_parser_default)
      end

      let(:expected) do
        <<~HEREDOC
          FEN: rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1
          Player playing white: w(white)
          Player playing black: b(black)
          Log:
          Metadata:


        HEREDOC
      end

      it 'returns a string based on the Position' do
        result = position_default.to_s
        expect(result).to eq(expected)
      end
    end
  end
end
