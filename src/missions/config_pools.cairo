use jokers_of_neon_lib::models::data::poker_hand::PokerHand;
use jokers_of_neon_lib::models::mission::mission_type::{MissionType, MissionDifficulty, MissionCycle};
use jokers_of_neon_lib::models::mission::mission_config::{
    MissionConfig, create_score_mission, create_hand_mission, create_threshold_mission
};

// ============================================
// DAILY MISSIONS - EASY (XP base: 10)
// ============================================
pub fn get_daily_easy_configs() -> Array<MissionConfig> {
    array![
        // Score 2000
        create_score_mission(1, MissionDifficulty::Easy, MissionCycle::Daily, 2000, 10),
        // Compra 1 special
        create_threshold_mission(2, MissionType::BuySpecials, MissionDifficulty::Easy, MissionCycle::Daily, 1, 10),
        // Quema 1 carta
        create_threshold_mission(3, MissionType::BurnCards, MissionDifficulty::Easy, MissionCycle::Daily, 1, 10),
        // Vende 1 special
        create_threshold_mission(4, MissionType::SellSpecials, MissionDifficulty::Easy, MissionCycle::Daily, 1, 10),
        // Juega High Card
        create_hand_mission(5, MissionDifficulty::Easy, MissionCycle::Daily, PokerHand::HighCard, false, 10),
        // Juega Pair
        create_hand_mission(6, MissionDifficulty::Easy, MissionCycle::Daily, PokerHand::OnePair, false, 10),
        // Juega Two Pair
        create_hand_mission(7, MissionDifficulty::Easy, MissionCycle::Daily, PokerHand::TwoPair, false, 10),
        // Ten 5 cartas neon en deck
        create_threshold_mission(8, MissionType::NeonCardsInDeck, MissionDifficulty::Easy, MissionCycle::Daily, 5, 10),
        // Gana 1 ronda de rage
        create_threshold_mission(9, MissionType::WinRageRounds, MissionDifficulty::Easy, MissionCycle::Daily, 1, 10),
        // Gana en tu última mano
        create_threshold_mission(10, MissionType::WinOnLastHand, MissionDifficulty::Easy, MissionCycle::Daily, 1, 10),
        // Gana en tu primera mano
        create_threshold_mission(11, MissionType::WinOnFirstHand, MissionDifficulty::Easy, MissionCycle::Daily, 1, 10),
        // Usa ambos tipos de power-up
        create_threshold_mission(12, MissionType::UseBothPowerUpTypes, MissionDifficulty::Easy, MissionCycle::Daily, 1, 10),
    ]
}

// ============================================
// DAILY MISSIONS - MEDIUM (XP base: 20)
// ============================================
pub fn get_daily_medium_configs() -> Array<MissionConfig> {
    array![
        // Score 6000
        create_score_mission(100, MissionDifficulty::Medium, MissionCycle::Daily, 6000, 20),
        // Compra 3 specials
        create_threshold_mission(101, MissionType::BuySpecials, MissionDifficulty::Medium, MissionCycle::Daily, 3, 20),
        // Quema 3 cartas
        create_threshold_mission(102, MissionType::BurnCards, MissionDifficulty::Medium, MissionCycle::Daily, 3, 20),
        // Vende 3 specials
        create_threshold_mission(103, MissionType::SellSpecials, MissionDifficulty::Medium, MissionCycle::Daily, 3, 20),
        // Juega Three of a Kind
        create_hand_mission(104, MissionDifficulty::Medium, MissionCycle::Daily, PokerHand::ThreeOfAKind, false, 20),
        // Juega Straight
        create_hand_mission(105, MissionDifficulty::Medium, MissionCycle::Daily, PokerHand::Straight, false, 20),
        // Juega Flush
        create_hand_mission(106, MissionDifficulty::Medium, MissionCycle::Daily, PokerHand::Flush, false, 20),
        // Juega Full House
        create_hand_mission(107, MissionDifficulty::Medium, MissionCycle::Daily, PokerHand::FullHouse, false, 20),
        // Juega Neon Pair (variante neon)
        create_hand_mission(108, MissionDifficulty::Medium, MissionCycle::Daily, PokerHand::OnePair, true, 25),
        // Ten 10 cartas neon en deck
        create_threshold_mission(109, MissionType::NeonCardsInDeck, MissionDifficulty::Medium, MissionCycle::Daily, 10, 20),
        // Ten 5 jokers en deck
        create_threshold_mission(110, MissionType::JokersInDeck, MissionDifficulty::Medium, MissionCycle::Daily, 5, 20),
        // Gana 3 rondas de rage
        create_threshold_mission(111, MissionType::WinRageRounds, MissionDifficulty::Medium, MissionCycle::Daily, 3, 20),
        // Gana sin descartar
        create_threshold_mission(112, MissionType::WinWithoutDiscards, MissionDifficulty::Medium, MissionCycle::Daily, 1, 20),
        // Acumula 15000 cash
        create_threshold_mission(113, MissionType::CashThreshold, MissionDifficulty::Medium, MissionCycle::Daily, 15000, 20),
        // Juega 3 jokers en una mano
        create_threshold_mission(114, MissionType::PlayJokers, MissionDifficulty::Medium, MissionCycle::Daily, 3, 20),
        // Sube una mano a nivel 3
        create_threshold_mission(115, MissionType::LevelUpPokerHand, MissionDifficulty::Medium, MissionCycle::Daily, 3, 20),
        // Juega 20 high cards (accumulated)
        create_threshold_mission(116, MissionType::PlayMultipleHighCard, MissionDifficulty::Medium, MissionCycle::Daily, 20, 20),
    ]
}

// ============================================
// DAILY MISSIONS - HARD (XP base: 30)
// ============================================
pub fn get_daily_hard_configs() -> Array<MissionConfig> {
    array![
        // Score 15000
        create_score_mission(200, MissionDifficulty::Hard, MissionCycle::Daily, 15000, 30),
        // Compra 5 specials
        create_threshold_mission(201, MissionType::BuySpecials, MissionDifficulty::Hard, MissionCycle::Daily, 5, 30),
        // Juega Four of a Kind
        create_hand_mission(202, MissionDifficulty::Hard, MissionCycle::Daily, PokerHand::FourOfAKind, false, 30),
        // Juega Straight Flush
        create_hand_mission(203, MissionDifficulty::Hard, MissionCycle::Daily, PokerHand::StraightFlush, false, 30),
        // Juega Five of a Kind
        create_hand_mission(204, MissionDifficulty::Hard, MissionCycle::Daily, PokerHand::FiveOfAKind, false, 30),
        // Juega Royal Flush
        create_hand_mission(205, MissionDifficulty::Hard, MissionCycle::Daily, PokerHand::RoyalFlush, false, 30),
        // Juega Neon Flush (variante neon)
        create_hand_mission(206, MissionDifficulty::Hard, MissionCycle::Daily, PokerHand::Flush, true, 30),
        // Juega Royal Flush Neon (variante neon)
        create_hand_mission(207, MissionDifficulty::Hard, MissionCycle::Daily, PokerHand::RoyalFlush, true, 30),
        // Ten 1 neon joker en deck
        create_threshold_mission(208, MissionType::NeonJokersInDeck, MissionDifficulty::Hard, MissionCycle::Daily, 1, 30),
        // Ten 100 cartas en deck
        create_threshold_mission(209, MissionType::DeckSize, MissionDifficulty::Hard, MissionCycle::Daily, 100, 30),
        // Desbloquea 7 special slots
        create_threshold_mission(210, MissionType::SpecialSlots, MissionDifficulty::Hard, MissionCycle::Daily, 7, 30),
        // Gana 5 rondas de rage
        create_threshold_mission(211, MissionType::WinRageRounds, MissionDifficulty::Hard, MissionCycle::Daily, 5, 30),
        // Sube una mano a nivel 10
        create_threshold_mission(212, MissionType::LevelUpPokerHand, MissionDifficulty::Hard, MissionCycle::Daily, 10, 30),
        // Juega 3 neon jokers en una mano
        create_threshold_mission(213, MissionType::PlayNeonJokers, MissionDifficulty::Hard, MissionCycle::Daily, 3, 30),
        // Encuentra un joker en loot box
        create_threshold_mission(214, MissionType::FindJokerInLootBox, MissionDifficulty::Hard, MissionCycle::Daily, 1, 30),
    ]
}

// ============================================
// WEEKLY MISSIONS - EASY (XP base: 50)
// ============================================
pub fn get_weekly_easy_configs() -> Array<MissionConfig> {
    array![
        // Score 10000 semanal
        create_score_mission(300, MissionDifficulty::Easy, MissionCycle::Weekly, 10000, 50),
        // Compra 5 specials semanal
        create_threshold_mission(301, MissionType::BuySpecials, MissionDifficulty::Easy, MissionCycle::Weekly, 5, 50),
        // Quema 5 cartas semanal
        create_threshold_mission(302, MissionType::BurnCards, MissionDifficulty::Easy, MissionCycle::Weekly, 5, 50),
        // Gana 3 rondas de rage
        create_threshold_mission(303, MissionType::WinRageRounds, MissionDifficulty::Easy, MissionCycle::Weekly, 3, 50),
        // Ten 15 cartas neon en deck
        create_threshold_mission(304, MissionType::NeonCardsInDeck, MissionDifficulty::Easy, MissionCycle::Weekly, 15, 50),
        // Acumula 30000 cash
        create_threshold_mission(305, MissionType::CashThreshold, MissionDifficulty::Easy, MissionCycle::Weekly, 30000, 50),
    ]
}

// ============================================
// WEEKLY MISSIONS - MEDIUM (XP base: 100)
// ============================================
pub fn get_weekly_medium_configs() -> Array<MissionConfig> {
    array![
        // Score 30000 semanal
        create_score_mission(400, MissionDifficulty::Medium, MissionCycle::Weekly, 30000, 100),
        // Compra 10 specials semanal
        create_threshold_mission(401, MissionType::BuySpecials, MissionDifficulty::Medium, MissionCycle::Weekly, 10, 100),
        // Quema 10 cartas semanal
        create_threshold_mission(402, MissionType::BurnCards, MissionDifficulty::Medium, MissionCycle::Weekly, 10, 100),
        // Gana 7 rondas de rage
        create_threshold_mission(403, MissionType::WinRageRounds, MissionDifficulty::Medium, MissionCycle::Weekly, 7, 100),
        // Ten 5 jokers en deck
        create_threshold_mission(404, MissionType::JokersInDeck, MissionDifficulty::Medium, MissionCycle::Weekly, 5, 100),
        // Acumula 75000 cash
        create_threshold_mission(405, MissionType::CashThreshold, MissionDifficulty::Medium, MissionCycle::Weekly, 75000, 100),
        // Juega Straight Flush
        create_hand_mission(406, MissionDifficulty::Medium, MissionCycle::Weekly, PokerHand::StraightFlush, false, 100),
        // Juega Neon Full House
        create_hand_mission(407, MissionDifficulty::Medium, MissionCycle::Weekly, PokerHand::FullHouse, true, 120),
    ]
}

// ============================================
// WEEKLY MISSIONS - HARD (XP base: 150)
// ============================================
pub fn get_weekly_hard_configs() -> Array<MissionConfig> {
    array![
        // Score 50000 semanal
        create_score_mission(500, MissionDifficulty::Hard, MissionCycle::Weekly, 50000, 150),
        // Compra 20 specials semanal
        create_threshold_mission(501, MissionType::BuySpecials, MissionDifficulty::Hard, MissionCycle::Weekly, 20, 150),
        // Gana 15 rondas de rage
        create_threshold_mission(502, MissionType::WinRageRounds, MissionDifficulty::Hard, MissionCycle::Weekly, 15, 150),
        // Ten 3 neon jokers en deck
        create_threshold_mission(503, MissionType::NeonJokersInDeck, MissionDifficulty::Hard, MissionCycle::Weekly, 3, 150),
        // Desbloquea 7 special slots
        create_threshold_mission(504, MissionType::SpecialSlots, MissionDifficulty::Hard, MissionCycle::Weekly, 7, 150),
        // Sube una mano a nivel 10
        create_threshold_mission(505, MissionType::LevelUpPokerHand, MissionDifficulty::Hard, MissionCycle::Weekly, 10, 150),
        // Juega Royal Flush
        create_hand_mission(506, MissionDifficulty::Hard, MissionCycle::Weekly, PokerHand::RoyalFlush, false, 150),
        // Juega Neon Royal Flush
        create_hand_mission(507, MissionDifficulty::Hard, MissionCycle::Weekly, PokerHand::RoyalFlush, true, 200),
    ]
}

// Helper to get pool by difficulty and cycle
pub fn get_configs_for_pool(difficulty: MissionDifficulty, cycle: MissionCycle) -> Array<MissionConfig> {
    match cycle {
        MissionCycle::None => array![],
        MissionCycle::Daily => {
            match difficulty {
                MissionDifficulty::None => array![],
                MissionDifficulty::Easy => get_daily_easy_configs(),
                MissionDifficulty::Medium => get_daily_medium_configs(),
                MissionDifficulty::Hard => get_daily_hard_configs(),
            }
        },
        MissionCycle::Weekly => {
            match difficulty {
                MissionDifficulty::None => array![],
                MissionDifficulty::Easy => get_weekly_easy_configs(),
                MissionDifficulty::Medium => get_weekly_medium_configs(),
                MissionDifficulty::Hard => get_weekly_hard_configs(),
            }
        },
    }
}
