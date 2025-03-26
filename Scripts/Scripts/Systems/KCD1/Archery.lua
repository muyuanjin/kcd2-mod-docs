Archery = {}

Archery.shootmaster =
{
    ['aus_shootmaster'] =
    {
        shootingRange = 'q_archery_uzice',
        difficulty = {
        ['beginer'] = {
            bet = 10,
            arrows = 7,
        },
        ['advanced'] = {
            bet = 30,
            arrows = 13,
        },
        ['expert'] = {
            bet = 70,
            arrows = 21,
        }
        },
    },
    ['tal_shootmaster'] =
    {
        shootingRange = 'q_archery_mrchojedy',
        difficulty = {
        ['beginer'] = {
            bet = 10,
            arrows = 7,
        },
        ['advanced'] = {
            bet = 30,
            arrows = 13,
        },
        ['expert'] = {
            bet = 70,
            arrows = 21,
        }
        },
    },
    ['rat_shootmaster'] =
    {
        shootingRange = 'q_archery_rataje',
        difficulty = {
        ['beginer'] = {
            bet = 10,
            arrows = 7,
        },
        ['advanced'] = {
            bet = 30,
            arrows = 13,
        },
        ['expert'] = {
            bet = 70,
            arrows = 21,
        }
        },
    },
	['prib_shootmaster'] =
    {
        shootingRange = 'q_archery_pribyslavice',
        difficulty = {
        ['beginer'] = {
            bet = 10,
            arrows = 7,
        },
        ['advanced'] = {
            bet = 30,
            arrows = 13,
        },
        ['expert'] = {
            bet = 70,
            arrows = 21,
        }
        },
    },

	['q_theresa_skao_shootmaster'] =
    {
        shootingRange = 'q_archery_skalice',
        difficulty = {
        ['beginer'] = {
            bet = 10,
            arrows = 7,
        },
        ['advanced'] = {
            bet = 30,
            arrows = 13,
        },
        ['expert'] = {
            bet = 70,
            arrows = 21,
        }
        },
    }
}

-- =============================================================================
Archery.getShootingRange = function (shootmaster)
    return Archery.shootmaster[shootmaster].shootingRange
end

-- =============================================================================
Archery.getMoneyBet = function (shootmaster, difficulty)
    return Archery.shootmaster[shootmaster].difficulty[difficulty].bet
end

-- =============================================================================
Archery.getArrows = function (shootmaster, difficulty)
    return Archery.shootmaster[shootmaster].difficulty[difficulty].arrows
end