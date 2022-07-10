Auth = exports.plouffe_lib:Get("Auth")
Callback = exports.plouffe_lib:Get("Callback")

Server = {
	WebHook = "",
	LogWebHook = "",
	Init = false,
	Callbacks = {},
    society = "society_pdm",
    Orders = {},
    OrderThreadActive = false,
    OrdersSleep = 1000 * 60 * 10
}

Pdm = {}
PdmFnc = {} 

Pdm.Player = {}
Pdm.Vehicles_list = {}
Pdm.StockVehicles = {}
Pdm.Display = {}
Pdm.Displayed = {}

Pdm.NewCar = {
    spawn_coords = vector3(-23.775897979736, -1094.3702392578, 27.305234909058),
    spawn_heading = 341.70794677734375
}

Pdm.JobPercentOnSales = 10

Pdm.Demo = {
    netId = 0,
    coords = vector3(-23.775897979736, -1094.3702392578, 27.305234909058),
    heading = 341.70794677734375
}

Pdm.PlaceOrderGrades = {
    ["2"] = true,
    ["3"] = true,
    ["4"] = true
}

Pdm.Menu = {
    employee = {
        {
            id = 1,
            header = "Liste des véhicules",
            txt = "Voir tous les véhicules disponible",
            params = {
                event = "",
                args = {
                    fnc = "OpenClassList"
                }
            }
        },

        {
            id = 2,
            header = "Ranger le demonstrateur",
            txt = "Range le demonstrateur, si il y en a un",
            params = {
                event = "",
                args = {
                    fnc = "RemoveDemoCar"
                }
            }
        },

        {
            id = 3,
            header = "Voir les stock",
            txt = "Voir tous les véhicules disponible en stock",
            params = {
                event = "",
                args = {
                    fnc = "OpenStockMenu"
                }
            }
        },

        {
            id = 4,
            header = "Retirer un display",
            txt = "Retirer un véhicule du plancher",
            params = {
                event = "",
                args = {
                    fnc = "RemoveDisplay"
                }
            }
        },

        {
            id = 5,
            header = "Factures",
            txt = "Faire une facture",
            params = {
                event = "",
                args = {
                    fnc = "OpenBilling"
                }
            }
        },

        {
            id = 6,
            header = "Commandes",
            txt = "Voir les véhicules en commande",
            params = {
                event = "",
                args = {
                    fnc = "SeeAllOrders"
                }
            }
        }

    },

    boss = {
        {
            id = 1,
            header = "Liste des véhicules",
            txt = "Voir tous les véhicules disponible",
            params = {
                event = "",
                args = {
                    fnc = "OpenClassList"
                }
            }
        },

        {
            id = 2,
            header = "Ranger le demonstrateur",
            txt = "Range le demonstrateur, si il y en a un",
            params = {
                event = "",
                args = {
                    fnc = "RemoveDemoCar"
                }
            }
        },

        {
            id = 3,
            header = "Voir les stock",
            txt = "Voir tous les véhicules disponible en stock",
            params = {
                event = "",
                args = {
                    fnc = "OpenStockMenu"
                }
            }
        },

        {
            id = 4,
            header = "Retirer un display",
            txt = "Retirer un véhicule du plancher",
            params = {
                event = "",
                args = {
                    fnc = "RemoveDisplay"
                }
            }
        },

        {
            id = 5,
            header = "Factures",
            txt = "Faire une facture",
            params = {
                event = "",
                args = {
                    fnc = "OpenBilling"
                }
            }
        },

        {
            id = 6,
            header = "Commandes",
            txt = "Voir les véhicules en commande",
            params = {
                event = "",
                args = {
                    fnc = "SeeAllOrders"
                }
            }
        },

        {
            id = 7,
            header = "Menu Patron",
            txt = "Ouvrir le menu patron",
            params = {
                event = "",
                args = {
                    fnc = "OpenBossMenu"
                }
            }
        }
    },

    class_demo = {
        {
            id = 1,
            header = "Super",
            txt = "Véhicules de type super",
            params = {
                event = "",
                args = {
                    fnc = "OpenSpecificClassVehicles",
                    class = "super"
                }
            }
        },

        {
            id = 2,
            header = "Moto",
            txt = "Véhicules de type moto",
            params = {
                event = "",
                args = {
                    fnc = "OpenSpecificClassVehicles",
                    class = "motorcycles"
                }
            }
        },

        {
            id = 3,
            header = "Velo",
            txt = "Véhicules de type velo",
            params = {
                event = "",
                args = {
                    fnc = "OpenSpecificClassVehicles",
                    class = "velo"
                }
            }
        },

        {
            id = 4,
            header = "Sports",
            txt = "Véhicules de type sports",
            params = {
                event = "",
                args = {
                    fnc = "OpenSpecificClassVehicles",
                    class = "sports"
                }
            }
        },

        {
            id = 5,
            header = "compacts",
            txt = "Véhicules de type compacts",
            params = {
                event = "",
                args = {
                    fnc = "OpenSpecificClassVehicles",
                    class = "compacts"
                }
            }
        },

        {
            id = 6,
            header = "Sedans",
            txt = "Véhicules de type sedans",
            params = {
                event = "",
                args = {
                    fnc = "OpenSpecificClassVehicles",
                    class = "sedans"
                }
            }
        },

        {
            id = 7,
            header = "SportsClassic",
            txt = "Véhicules de type Sports Classic",
            params = {
                event = "",
                args = {
                    fnc = "OpenSpecificClassVehicles",
                    class = "sportsclassics"
                }
            }
        },

        {
            id = 8,
            header = "Sports",
            txt = "Véhicules de type sports",
            params = {
                event = "",
                args = {
                    fnc = "OpenSpecificClassVehicles",
                    class = "sports"
                }
            }
        },

        {
            id = 9,
            header = "Muscle",
            txt = "Véhicules de type muscle",
            params = {
                event = "",
                args = {
                    fnc = "OpenSpecificClassVehicles",
                    class = "muscle"
                }
            }
        },

        {
            id = 10,
            header = "Coupes",
            txt = "Véhicules de type coupes",
            params = {
                event = "",
                args = {
                    fnc = "OpenSpecificClassVehicles",
                    class = "coupes"
                }
            }
        },

        {
            id = 11,
            header = "Suvs",
            txt = "Véhicules de type suvs",
            params = {
                event = "",
                args = {
                    fnc = "OpenSpecificClassVehicles",
                    class = "suvs"
                }
            }
        },

        {
            id = 12,
            header = "Offroad",
            txt = "Véhicules de type offroad",
            params = {
                event = "",
                args = {
                    fnc = "OpenSpecificClassVehicles",
                    class = "offroad"
                }
            }
        },

        {
            id = 13,
            header = "Utilitaire",
            txt = "Véhicules de type utilitaire",
            params = {
                event = "",
                args = {
                    fnc = "OpenSpecificClassVehicles",
                    class = "utility"
                }
            }
        },

        {
            id = 14,
            header = "Vans",
            txt = "Véhicules de type vans",
            params = {
                event = "",
                args = {
                    fnc = "OpenSpecificClassVehicles",
                    class = "vans"
                }
            }
        }
    },

    cancel_creator = {
        {
            id = 1,
            header = "Etes vous certain de vouloir annuler ?",
            txt = "Appuier sur OUI pour confirmer",
            params = {
                event = "",
                args = {
                }
            }
        },
        {
            id = 2,
            header = "OUI",
            txt = "Annuler ",
            params = {
                event = "",
                args = {
                    confirm = true
                }
            }
        },
        {
            id = 3,
            header = "NON",
            txt = "Continuer",
            params = {
                event = "",
                args = {
                }
            }
        }
    },

    confirm_placement = {
        {
            id = 1,
            header = "Etes vous certain de vouloir confimer l'emplacement ?",
            txt = "Appuier sur OUI pour confirmer",
            params = {
                event = "",
                args = {
                }
            }
        },
        {
            id = 2,
            header = "OUI",
            txt = "Confirmer ",
            params = {
                event = "",
                args = {
                    confirm = true
                }
            }
        },
        {
            id = 3,
            header = "NON",
            txt = "Annuler",
            params = {
                event = "",
                args = {
                }
            }
        }
    }
}

Pdm.Utils = {
	ped = 0,
	pedCoords = vector3(0,0,0),
    boss_grade = 4
}

Pdm.Zones = {
    pdm_auto_zone = {
        name = "pdm_auto_zone",
        coords = vector3(-39.179607391357, -1100.7562255859, 26.422357559204),
        maxDst = 100.0,
        protectEvents = true,
        isZone = true,
        zoneMap = {
            shouldTriggerEvent = true,
            inEvent = "plouffe_pdm:entered_shop_zone",
            outEvent = "plouffe_pdm:left_shop_zone"
        }
    },

    pdm_auto_zone_interior = {
        name = "pdm_auto_zone_interior",
        coords = vector3(-39.179607391357, -1100.7562255859, 26.422357559204),
        maxDst = 50.0,
        protectEvents = true,
        isZone = true,
        zoneMap = {
            shouldTriggerEvent = true,
            inEvent = "plouffe_pdm:replace_vehicles"
        }
    },
    
    pdm_employee_menu = {
		name = "pdm_employee_menu",
		coords = vector3(-25.599361419678, -1104.5484619141, 27.274263381958),
		maxDst = 2.0,
		protectEvents = true,
		isKey = true,
		isZone = true,
		nuiLabel = "Menu Pdm",
        jobs = {"pdm"},
        aditionalParams = {fnc = "OpenEmployeeMenu"},
		keyMap = {
			checkCoordsBeforeTrigger = true,
			onRelease = true,
			releaseEvent = "plouffe_pdm:on_zones",
			key = "E"
		}
	},

    pdm_employee_menu2 = {
		name = "pdm_employee_menu2",
		coords = vector3(-26.984169006348, -1108.3502197266, 27.274276733398),
		maxDst = 2.0,
		protectEvents = true,
		isKey = true,
		isZone = true,
		nuiLabel = "Menu Pdm",
        jobs = {"pdm"},
        aditionalParams = {fnc = "OpenEmployeeMenu"},
		keyMap = {
			checkCoordsBeforeTrigger = true,
			onRelease = true,
			releaseEvent = "plouffe_pdm:on_zones",
			key = "E"
		}
	},

    pdm_add_owned_vehicle = {
		name = "pdm_add_owned_vehicle",
		coords = vector3(-23.775897979736, -1094.3702392578, 27.305234909058),
		maxDst = 4.0,
		protectEvents = true,
		isKey = true,
		isZone = true,
		nuiLabel = "Ajouter un véhicule dans l'inventaire",
        jobs = {"pdm"},
        aditionalParams = {fnc = "AddOwnedVehicleToInventory"},
		keyMap = {
			checkCoordsBeforeTrigger = true,
			onRelease = true,
			releaseEvent = "plouffe_pdm:on_zones",
			key = "E"
		}
	}
}

Pdm.DeliveryTimes = {
    randoms = {
        super = {min = 1 * 60 * 60 * 48, max = 1 * 60 * 60 * 72},
        sportsclassics = {min = 1 * 60 * 60 * 36, max = 1 * 60 * 60 * 48},
        sports = {min = 1 * 60 * 60 * 24, max = 1 * 60 * 60 * 36},
        
        muscle = {min = 1 * 60 * 60 * 12, max = 1 * 60 * 60 * 24},
        coupes = {min = 1 * 60 * 60 * 12, max = 1 * 60 * 60 * 24},
        sedans = {min = 1 * 60 * 60 * 12, max = 1 * 60 * 60 * 24},
        
        utility = {min = 1 * 60 * 60 * 12, max = 1 * 60 * 60 * 24},
        vans = {min = 1 * 60 * 60 * 12, max = 1 * 60 * 60 * 24},
        offroad = {min = 1 * 60 * 60 * 12, max = 1 * 60 * 60 * 24},
        
        compacts = {min = 1 * 60 * 60 * 6, max = 1 * 60 * 60 * 12},
        motorcycles = {min = 1 * 60 * 60 * 6, max = 1 * 60 * 60 * 12},
        suvs = {min = 1 * 60 * 60 * 6, max = 1 * 60 * 60 * 12},
        
        velo  = {min = 1 * 60 * 60 * 1, max = 1 * 60 * 60 * 6}
    },

    set = {
        super = 0,
        sportsclassics = 0,
        sports = 0,
        
        muscle = 0,
        coupes = 0,
        sedans = 0,
        
        utility = 0,
        vans = 0,
        offroad = 0,
        
        compacts = 0,
        motorcycles = 0,
        suvs = 0,
        
        velo  = 0,
    }
}

Pdm.DisplayInfo = {
    canceled = false,
    inDisplay = false,
    vehicle_data = {},
    currentSpeed = 0.1,
    offSets = {
        x = 0.1,
        y = 0.1,
        z = 0.1,
        h = 0.5,
        pitch = 0.1, 
        roll = 0.1, 
        yaw = 0.5
    },
    keys = {
        ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
        ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
        ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
        ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
        ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
        ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
        ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
        ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
        ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118,
        ["WHEELUP"] = 17, ["WHEELDOWN"] = 16, ["RIGHTMOUSE"] = 222
    }
}

Pdm.Vehicles_list.super = {
    adder = { 
        label = 'Adder Truffade',
        model = 'adder',
        price = 330000,
        class = 'super'
    },

	autarch = { 
        label = 'Autarch Overflod',
        model = 'autarch',
        price = 375000,
        class = 'super'
    },

	banshee2 = { 
        label = 'Banshee 900R Bravado',
        model = 'banshee2',
        price = 200000,
        class = 'super'
    },

	bullet = { 
        label = 'Bullet Vapid',
        model = 'bullet',
        price = 95000,
        class = 'super'
    },

	cheetah = { 
        label = 'Cheetah Grotti',
        model = 'cheetah',
        price = 150000,
        class = 'super'
    },

	cyclone = { 
        label = 'Cyclone Coil',
        model = 'cyclone',
        price = 150000,
        class = 'super'
    },

	deveste = { 
        label = 'Deveste Eight Principe',
        model = 'deveste',
        price = 400000,
        class = 'super'
    },

	emerus = { 
        label = 'Progen Emerus',
        model = 'emerus',
        price = 200000,
        class = 'super'
    },

	entity2 = { 
        label = 'Entity XXR Overflod',
        model = 'entity2',
        price = 175000,
        class = 'super'
    },

	entityxf = { 
        label = 'Entity XF Overflod',
        model = 'entityxf',
        price = 150000,
        class = 'super'
    },

	fmj = { 
        label = 'FMJ Vapid',
        model = 'fmj',
        price = 300000,
        class = 'super'
    },

	furia = { 
        label = 'Grotti Furia',
        model = 'furia',
        price = 230000,
        class = 'super'
    },

	gp1 = { 
        label = 'GP1 Progen',
        model = 'gp1',
        price = 100000,
        class = 'super'
    },

	infernus = { 
        label = 'Infernus Pegassi',
        model = 'infernus',
        price = 135000,
        class = 'super'
    },

	italigtb = { 
        label = 'Itali GTB Progen',
        model = 'italigtb',
        price = 200000,
        class = 'super'
    },

	italigtb2 = { 
        label = 'Itali GTB Custom',
        model =  'italigtb2',
        price = 200000,
        class = 'super'
    },

	krieger = { 
        label = 'Benefactor Krieger',
        model = 'krieger',
        price = 250000,
        class = 'super'
    },

	le7b = { 
        label = 'RE-7B Annis',
        model = 'le7b',
        price = 225000,
        class = 'super'
    },

	locust = { 
        label = 'Ocelot Locust',
        model = 'locust',
        price = 250000,
        class = 'super'
    },

	neo = { 
        label = 'Vysser Neo',
        model = 'neo',
        price = 175000,
        class = 'super'
    },

	nero = { 
        label = 'Nero Truffade',
        model = 'nero',
        price = 375000,
        class = 'super'
    },

	nero2 = { 
        label = 'Nero Custom Truffade',
        model = 'nero2',
        price = 375000,
        class = 'super'
    },

	osiris = { 
        label = 'Osiris Pegassi',
        model = 'osiris',
        price = 250000,
        class = 'super'
    },

	paragon = { 
        label = 'Enus Paragon',
        model = 'paragon',
        price = 100000,
        class = 'super'
    },

	penetrator = { 
        label = 'Penetrator Ocelot',
        model =  'penetrator',
        price = 135000,
        class = 'super'
    },

	pfister811 = { 
        label = '811 Pfister',
        model =  'pfister811',
        price = 200000,
        class = 'super'
    },

	prototipo = { 
        label = 'X80 Proto Grotti',
        model =  'prototipo',
        price = 300000,
        class = 'super'
    },

	Reaper = { 
        label = 'Reaper',
        model = 'Reaper',
        price = 150000,
        class = 'super'
    },

	s80 = { 
        label = 'Annis S80 RR',
        model = 's80',
        price = 300000,
        class = 'super'
    },

	sc1 = { 
        label = 'SC1 Ubermacht',
        model = 'sc1',
        price = 160000,
        class = 'super'
    },

	sheava = { 
        label = 'ETR1 Emperor',
        model = 'sheava',
        price = 150000,
        class = 'super'
    },

	Sultanrs = { 
        label = 'Sultan RS Karin',
        model = 'Sultanrs',
        price = 75000,
        class = 'super'
    },

	t20 = { 
        label = 'T20 Progen',
        model = 't20',
        price = 250000,
        class = 'super'
    },

	Taipan = { 
        label = 'Taipan Cheval',
        model = 'Taipan',
        price = 250000,
        class = 'super'
    },

	tempesta = { 
        label = 'Tempesta Pegassi',
        model = 'tempesta',
        price = 170000,
        class = 'super'
    },

	tezeract = { 
        label = 'Tezeract Pegassi',
        model = 'tezeract',
        price = 225000,
        class = 'super'
    },

	thrax = { 
        label = 'Adder Thrax',
        model = 'thrax',
        price = 300000,
        class = 'super'
    },

	tigon = { 
        label = 'Lampadati Tigon',
        model = 'tigon',
        price = 160000,
        class = 'super'
    },

	turismor = { 
        label = 'Turismo R Grotti',
        model = 'turismor',
        price = 150000,
        class = 'super'
    },

	Tyrant = { 
        label = 'Tyrant Overflod',
        model = 'Tyrant',
        price = 200000,
        class = 'super'
    },

	Tyrus = { 
        label = 'Tyrus Progen',
        model = 'Tyrus',
        price = 150000,
        class = 'super'
    },

	vacca = { 
        label = 'Vacca Pegassi',
        model = 'vacca',
        price = 100000,
        class = 'super'
    },

	vagner = { 
        label = 'Vagner Dewbauchee',
        model = 'vagner',
        price = 200000,
        class = 'super'
    },

	visione = { 
        label = 'Visione',
        model = 'visione',
        price = 300000,
        class = 'super'
    },

	voltic = { 
        label = 'Voltic Coil',
        model = 'voltic',
        price = 115000,
        class = 'super'
    },

	Xa21 = { 
        label = 'XA-21 Ocelot',
        model = 'Xa21',
        price = 125000,
        class = 'super'
    },

	zentorno = { 
        label = 'Zentorno Pegassi',
        model = 'zentorno',
        price = 180000,
        class = 'super'
    },

	zorrusso = { 
        label = 'Pegassi Zorrusso',
        model = 'zorrusso',
        price = 350000,
        class = 'super'
    },

    ignus = { 
        label = 'Ignus',
        model = 'ignus',
        price = 300000,
        class = 'super'
    },
    
    zeno = { 
        label = 'Zeno',
        model = 'zeno',
        price = 290000,
        class = 'super'
    },

    italirsx = { 
        label = 'Itali Rsx',
        model = 'italirsx',
        price = 290000,
        class = 'super'
    }
}

Pdm.Vehicles_list.motorcycles = {
    akuma = {
        label = 'Akuma',
        model = 'akuma',
        price = 17500,
        class =  'motorcycles',
    },

	avarus = {
        label = 'Avarus',
        model = 'avarus',
        price = 25000,
        class =  'motorcycles',
    },

	bagger = {
        label = 'Bagger',
        model = 'bagger',
        price = 22000,
        class =  'motorcycles',
    },

	bati = {
        label = 'Bati 801',
        model = 'bati',
        price = 30000,
        class =  'motorcycles',
    },

	bati2 = {
        label = 'Bati 801RR',
        model = 'bati2',
        price = 35000,
        class =  'motorcycles',
    },

	bf400 = {
        label = 'BF400',
        model = 'bf400',
        price = 30000,
        class =  'motorcycles',
    },

	carbonrs = {
        label = 'Carbon RS',
        model = 'carbonrs',
        price = 40000,
        class =  'motorcycles',
    },

	chimera = {
        label = 'Chimera',
        model = 'chimera',
        price = 25000,
        class =  'motorcycles',
    },

	cliffhanger = {
        label = 'Cliffhanger',
        model =  'cliffhanger',
        price = 22000,
        class =  'motorcycles',
    },

	daemon = {
        label = 'Daemon',
        model = 'daemon',
        price = 45000,
        class =  'motorcycles',
    },

	daemon2 = {
        label = 'Daemon High',
        model = 'daemon2',
        price = 35000,
        class =  'motorcycles',
    },

	defiler = {
        label = 'Defiler',
        model = 'defiler',
        price = 50000,
        class =  'motorcycles',
    },

	diablous2 = {
        label = 'Diabolus Custom',
        model =  'diablous2',
        price = 50000,
        class =  'motorcycles',
    },

	double = {
        label = 'Double T',
        model = 'double',
        price = 50000,
        class =  'motorcycles',
    },

	enduro = {
        label = 'Enduro',
        model = 'enduro',
        price = 35000,
        class =  'motorcycles',
    },

	esskey = {
        label = 'Esskey',
        model = 'esskey',
        price = 15000,
        class =  'motorcycles',
    },

	faggio = {
        label = 'Faggio',
        model = 'faggio',
        price = 700,
        class =  'motorcycles',
    },

	faggio2 = {
        label = 'Vespa',
        model = 'faggio2',
        price = 800,
        class =  'motorcycles',
    },

	fcr = {
        label = 'Pegassi FCR1000',
        model = 'fcr',
        price = 30000,
        class =  'motorcycles',
    },

	fcr2 = {
        label = 'Pegassi FCR1000 Custom',
        model = 'fcr2',
        price = 30000,
        class =  'motorcycles',
    },

	gargoyle = {
        label = 'Gargoyle',
        model = 'gargoyle',
        price = 35000,
        class =  'motorcycles',
    },

	hakuchou = {
        label = 'Hakuchou',
        model = 'hakuchou',
        price = 90000,
        class =  'motorcycles',
    },

	hakuchou2 = {
        label = 'Hakuchou Sport',
        model =  'hakuchou2',
        price = 90000,
        class =  'motorcycles',
    },

	hexer = {
        label = 'Hexer',
        model = 'hexer',
        price = 30000,
        class =  'motorcycles',
    },

	innovation = {
        label = 'Innovation',
        model =  'innovation',
        price = 45000,
        class =  'motorcycles',
    },

	manchez = {
        label = 'Manchez',
        model = 'manchez',
        price = 17500,
        class =  'motorcycles',
    },

	nemesis = {
        label = 'Nemesis',
        model = 'nemesis',
        price = 37000,
        class =  'motorcycles',
    },

	nightblade = {
        label = 'Nightblade',
        model =  'nightblade',
        price = 75000,
        class =  'motorcycles',
    },

	pcj = {
        label = 'PCJ-600',
        model = 'pcj',
        price = 20000,
        class =  'motorcycles',
    },

	rrocket = {
        label = 'Rampant Rocket',
        model = 'rrocket',
        price = 125000,
        class =  'motorcycles',
    },

	ruffian = {
        label = 'Ruffian',
        model = 'ruffian',
        price = 24500,
        class =  'motorcycles',
    },

	sanchez = {
        label = 'Sanchez',
        model = 'sanchez',
        price = 12500,
        class =  'motorcycles',
    },

	sanchez2 = {
        label = 'Sanchez Sport',
        model = 'sanchez2',
        price = 12500,
        class =  'motorcycles',
    },

	sanctus = {
        label = 'Sanctus',
        model = 'sanctus',
        price = 70000,
        class =  'motorcycles',
    },

	shotaro = {
        label = 'Shotaro Concept',
        model = 'shotaro',
        price = 200000,
        class =  'motorcycles',
    },

	sovereign = {
        label = 'Sovereign',
        model =  'sovereign',
        price = 20000,
        class =  'motorcycles',
    },

	stryder = {
        label = 'Nagasaki Stryder',
        model = 'stryder',
        price = 65000,
        class =  'motorcycles',
    },

	thrust = {
        label = 'Thrust',
        model = 'thrust',
        price = 25000,
        class =  'motorcycles',
    },

	vader = {
        label = 'Vader',
        model = 'vader',
        price = 25000,
        class =  'motorcycles',
    },

	vortex = {
        label = 'Vortex',
        model = 'vortex',
        price = 18000,
        class =  'motorcycles',
    },

	wolfsbane = {
        label = 'Woflsbane',
        model =  'wolfsbane',
        price = 11000,
        class =  'motorcycles',
    },

	zombiea = {
        label = 'Zombie',
        model = 'zombiea',
        price = 35000,
        class =  'motorcycles',
    },

	zombieb = {
        label = 'Zombie Luxuary',
        model = 'zombieb',
        price = 30000,
        class =  'motorcycles',
    },

    reever = {
        label = 'Reever',
        model = 'reever',
        price = 65000,
        class =  'motorcycles',
    },

    shinobi = {
        label = 'Shinobi',
        model = 'shinobi',
        price = 85000,
        class =  'motorcycles',
    },

    manchez2 = {
        label = 'Manchez Scout',
        model = 'manchez2',
        price = 75000,
        class =  'motorcycles',
    },

    verus = {
        label = 'Verus',
        model = 'verus',
        price = 80000,
        class =  'motorcycles',
    }
}

Pdm.Vehicles_list.velo = {
    bmx = {
        label = 'BMX (velo)',
        model = 'bmx',
        price = 50,
        class =  'velo'
    },

	cruiser = {
        label = 'Cruiser (velo)',
        model = 'cruiser',
        price = 50,
        class =  'velo'
    },

	fixter = {
        label = 'Fixter (velo)',
        model = 'fixter',
        price = 150,
        class =  'velo'
    },

	scorcher = {
        label = 'Scorcher (velo)',
        model = 'scorcher',
        price = 100,
        class =  'velo'
    },

	tribike3 = {
        label = 'Tri bike (velo)',
        model = 'tribike3',
        price = 250,
        class =  'velo'
    }
}

Pdm.Vehicles_list.compacts = {
    asbo = {
        label = 'Maxwell Asbo',
        model = 'asbo',
        price = 7500,
        class =  'compacts',
    },

	blista = {
        label = 'Blista Dinka',
        model = 'blista',
        price = 3000,
        class =  'compacts',
    },

	brioso = {
        label = 'Brioso R/A',
        model = 'brioso',
        price = 9500,
        class =  'compacts',
    },

	club = {
        label = 'BF Club',
        model = 'club',
        price = 17000,
        class =  'compacts',
    },

	dynasty = {
        label = 'Weeny Dynasty',
        model = 'dynasty',
        price = 25000,
        class =  'compacts',
    },

	issi2 = {
        label = 'Issi Weeny',
        model = 'issi2',
        price = 8000,
        class =  'compacts',
    },

	issi3 = {
        label = 'Issi Classique Weeny',
        model = 'issi3',
        price = 15000,
        class =  'compacts',
    },

	issi7 = {
        label = 'Weeny Issi RS',
        model = 'issi7',
        price = 100000,
        class =  'compacts',
    },

	kanjo = {
        label = 'Dinka Kanjo',
        model = 'kanjo',
        price = 55000,
        class =  'compacts',
    },

	panto = {
        label = 'Panto',
        model = 'panto',
        price = 2000,
        class =  'compacts',
    },

	prairie = {
        label = 'Prairie',
        model = 'prairie',
        price = 7500,
        class =  'compacts',
    },

	retinue2 = {
        label = 'Vapid Retinue Sport',
        model = 'retinue2',
        price = 30000,
        class =  'compacts',
    },

	Rhapsody = {
        label = 'Rhapsody',
        model = 'Rhapsody',
        price = 7500,
        class =  'compacts',
    }
}

Pdm.Vehicles_list.sedans = {
    asea = { 
        label = 'Asea',
        model = 'asea',
        price = 4500,
        class = 'sedans',
    },

	asterope = { 
        label = 'Karin Asterope',
        model = 'asterope',
        price = 5500,
        class = 'sedans',
    },

	buffalo4 = { 
        label = 'Buffalo Hellcat',
        model = 'buffalo4',
        price = 700000,
        class = 'sedans',
    },

	cognoscenti = { 
        label = 'Cognoscenti',
        model =  'cognoscenti',
        price = 95000,
        class = 'sedans',
    },

	emperor = { 
        label = 'Emperor',
        model = 'emperor',
        price = 4500,
        class = 'sedans',
    },

	fugitive = { 
        label = 'Fugitive',
        model = 'fugitive',
        price = 35000,
        class = 'sedans',
    },

	glendale = { 
        label = 'Glendale',
        model = 'glendale',
        price = 22000,
        class = 'sedans',
    },

	intruder = { 
        label = 'Intruder',
        model = 'intruder',
        price = 10000,
        class = 'sedans',
    },

	jugular = { 
        label = 'Ocelot Jugular',
        model = 'jugular',
        price = 100000,
        class = 'sedans',
    },

	premier = { 
        label = 'Premier',
        model = 'premier',
        price = 6000,
        class = 'sedans',
    },

	primo = { 
        label = 'Albany Primo',
        model = 'primo',
        price = 8000,
        class = 'sedans',
    },

	primo2 = { 
        label = 'Primo Custom',
        model = 'primo2',
        price = 18000,
        class = 'sedans',
    },

	regina = { 
        label = 'Regina',
        model = 'regina',
        price = 5000,
        class = 'sedans',
    },

	romero = { 
        label = 'Albany Romero Hearse',
        model = 'romero',
        price = 100000,
        class = 'sedans',
    },

	schafter2 = { 
        label = 'Schafter',
        model =  'schafter2',
        price = 35000,
        class = 'sedans',
    },

	stafford = { 
        label = 'Enus Stafford',
        model = 'stafford',
        price = 25000,
        class = 'sedans',
    },

	stanier = { 
        label = 'Stanier',
        model = 'stanier',
        price = 4200,
        class = 'sedans',
    },

	stretch = { 
        label = 'Stretch',
        model = 'stretch',
        price = 100000,
        class = 'sedans',
    },

	sultan2 = { 
        label = 'Karim Sultan WRX',
        model = 'sultan2',
        price = 125000,
        class = 'sedans',
    },

	superd = { 
        label = 'Super Diamond',
        model = 'superd',
        price = 45000,
        class = 'sedans',
    },

	surge = { 
        label = 'Cheval Surge',
        model = 'surge',
        price = 15000,
        class = 'sedans',
    },

	tailgater = { 
        label = 'Tailgater',
        model =  'tailgater',
        price = 18000,
        class = 'sedans',
    },

	vstr = { 
        label = 'Albany V-STR',
        model = 'vstr',
        price = 125000,
        class = 'sedans',
    },

	warrener = { 
        label = 'Warrener',
        model = 'warrener',
        price = 7500,
        class = 'sedans',
    },

	washington = { 
        label = 'Washington',
        model =  'washington',
        price = 6000,
        class = 'sedans',
    },

    cinquemila = {
        label = 'Cinquemila',
        model =  'Cinquemila',
        price = 85000,
        class = 'sedans'
    }
}

Pdm.Vehicles_list.sportsclassics = {
    feltzer3 = {
        label = 'Stirling GT Benefactor',
        model = 'feltzer3',
        price = 95000,
        class = 'sportsclassics'
    },

	btype = {
        label = 'Roosevelt Albany',
        model = 'btype',
        price = 65000,
        class = 'sportsclassics'
    },

	btype2 = {
        label = 'Franken Stange',
        model = 'btype2',
        price = 85000,
        class = 'sportsclassics'
    },

	btype3 = {
        label = 'Roosevelt Valor Albany',
        model = 'btype3',
        price = 65000,
        class = 'sportsclassics'
    },

	casco = {
        label = 'Casco',
        model = 'casco',
        price = 55000,
        class = 'sportsclassics'
    },

	cheburek = {
        label = 'Cheburek',
        model = 'cheburek',
        price = 12000,
        class = 'sportsclassics'
    },

	Cheetah2 = {
        label = 'Cheetah Classique',
        model = 'Cheetah2',
        price = 100000,
        class = 'sportsclassics'
    },

	coquette2 = {
        label = 'Coquette Classic Invetero',
        model = 'coquette2',
        price = 75000,
        class = 'sportsclassics'
    },

	fagaloa = {
        label = 'Vulcar Fagaloa',
        model = 'fagaloa',
        price = 15000,
        class = 'sportsclassics'
    },

	gauntlet3 = {
        label = 'Bravado Gauntlet Classic',
        model = 'gauntlet3',
        price = 55000,
        class = 'sportsclassics'
    },

	glendale2 = {
        label = 'Benefactor Glendale',
        model = 'glendale2',
        price = 45500,
        class = 'sportsclassics'
    },

	gt500 = {
        label = 'GT 500',
        model = 'gt500',
        price = 70000,
        class = 'sportsclassics'
    },

	Infernus2 = {
        label = 'Infernus Classique Pegassi',
        model = 'Infernus2',
        price = 150000,
        class = 'sportsclassics'
    },

	jb7002 = {
        label = 'Dewbauchee JB700-2',
        model = 'jb7002',
        price = 175000,
        class = 'sportsclassics'
    },

	Jester3 = {
        label = 'Jester3',
        model = 'Jester3',
        price = 100000,
        class = 'sportsclassics'
    },

	mamba = {
        label = 'Mamba Declasse',
        model = 'mamba',
        price = 250000,
        class = 'sportsclassics'
    },

	manana = {
        label = 'Manana',
        model = 'manana',
        price = 12500,
        class = 'sportsclassics'
    },

	monroe = {
        label = 'Monroe Pegassi',
        model = 'monroe',
        price = 100000,
        class = 'sportsclassics'
    },

	nebula = {
        label = 'Vulcar Nebula Turbo',
        model = 'nebula',
        price = 45000,
        class = 'sportsclassics'
    },

	peyote = {
        label = 'Peyote',
        model = 'peyote',
        price = 18500,
        class = 'sportsclassics'
    },

	peyote3 = {
        label = 'Vapide Peyote 70',
        model = 'peyote3',
        price = 55000,
        class = 'sportsclassics'
    },
    
	pigalle = {
        label = 'Pigalle',
        model = 'pigalle',
        price = 11000,
        class = 'sportsclassics'
    },
    
	rapidgt3 = {
        label = 'Rapid GT3',
        model = 'rapidgt3',
        price = 70000,
        class = 'sportsclassics'
    },
    
	retinue = {
        label = 'Vapid Retinue',
        model = 'retinue',
        price = 25000,
        class = 'sportsclassics'
    },
    
	stinger = {
        label = 'Stinger Grotti',
        model = 'stinger',
        price = 130000,
        class = 'sportsclassics'
    },
    
	stingergt = {
        label = 'Stinger GT Grotti',
        model = 'stingergt',
        price = 125000,
        class = 'sportsclassics'
    },
    
	Swinger = {
        label = 'Swinger',
        model = 'Swinger',
        price = 135000,
        class = 'sportsclassics'
    },
    
	torero = {
        label = 'Torero Pegassi',
        model = 'torero',
        price = 135000,
        class = 'sportsclassics'
    },
    
	tornado = {
        label = 'Tornado Declasse',
        model = 'tornado',
        price = 12000,
        class = 'sportsclassics'
    },
    
	tornado2 = {
        label = 'Tornado Convertible Declasse',
        model = 'tornado2',
        price = 13000,
        class = 'sportsclassics'
    },
    
	tornado3 = {
        label = 'Tornado Rouille Declasse',
        model = 'tornado3',
        price = 3500,
        class = 'sportsclassics'
    },
    
	tornado4 = {
        label = 'Tornado Rouille Convertible Declasse',
        model = 'tornado4',
        price = 5500,
        class = 'sportsclassics'
    },
    
	tornado5 = {
        label = 'Tornado Custom Declasse',
        model = 'tornado5',
        price = 25000,
        class = 'sportsclassics'
    },
    
	tornado6 = {
        label = 'Tornado Rat Rod Declasse',
        model = 'tornado6',
        price = 15000,
        class = 'sportsclassics'
    },
    
	Turismo2 = {
        label = 'Turismo Classique',
        model = 'Turismo2',
        price = 400000,
        class = 'sportsclassics'
    },
    
	viseris = {
        label = 'Viseris',
        model = 'viseris',
        price = 150000,
        class = 'sportsclassics'
    },
    
	yosemite2 = {
        label = 'Declasse Yosemite Turbo',
        model = 'yosemite2',
        price = 100000,
        class = 'sportsclassics'
    },
    
	z190 = {
        label = 'Z190',
        model = 'z190',
        price = 50000,
        class = 'sportsclassics'
    },
    
	ztype = {
        label = 'Z-Type Truffade',
        model = 'ztype',
        price = 225000,
        class = 'sportsclassics'
    },

    brioso2 = {
        label = 'Brioso 300',
        model = 'brioso2',
        price = 90000,
        class = 'sportsclassics'
    },

    weevil = {
        label = 'Weevil',
        model = 'weevil',
        price = 90000,
        class = 'sportsclassics'
    },

    toreador = {
        label = 'Toreador',
        model = 'toreador',
        price = 90000,
        class = 'sportsclassics'
    }
}

Pdm.Vehicles_list.sports = { 
    alpha = {
        label = 'Alpha',
        model = 'alpha',
        price = 27000,
        class = 'sports'
    },	
    banshee = {
        label = 'Banshee',
        model =  'banshee',
        price = 100000,
        class = 'sports'
	},
    bestiagts = {
        label = 'Bestia GTS',
        model =  'bestiagts',
        price = 125000,
        class = 'sports'
	},
    blista2 = {
        label = 'Blista Compact Dinka',
        model =  'blista2',
        price = 2500,
        class = 'sports'
	},
    buffalo = {
        label = 'Buffalo',
       model =  'buffalo',
        price = 47000,
        class = 'sports'
	},
    buffalo2 = {
        label = 'Buffalo S',
        model =  'buffalo2',
        price = 69000,
        class = 'sports'
	},
    carbonizzare = {
        label = 'Carbonizzare',
        model =  'carbonizzare',
        price = 100000,
        class = 'sports'
	},
    comet3 = {
        label = 'Comet Classic',
        model = 'comet3',
        price = 200000,
        class = 'sports'
	},
    comet4 = {
        label = 'Comet Safari',
        model = 'comet4',
        price = 100000,
        class = 'sports'
	},
    comet5 = {
        label = 'Comet SR Plister',
        model = 'comet5',
        price = 135000,
        class = 'sports'
	},
    coquette = {
        label = 'Coquette',
        model =  'coquette',
        price = 100000,
        class = 'sports'
	},
    coquette4 = {
        label = 'Coquette C8',
        model =  'coquette4',
        price = 115000,
        class = 'sports'
	},
    drafter = {
        label = 'Obey Drafter',
        model =  'drafter',
        price = 100000,
        class = 'sports'
	},
    elegy = {
        label = 'Elegy Retro Custom',
        model = 'elegy',
        price = 100000,
        class = 'sports'
	},
    elegy2 = {
        label = 'Elegy RH8',
        model = 'elegy2',
        price = 100000,
        class = 'sports'
	},
    feltzer2 = {
        label = 'Feltzer',
        model =  'feltzer2',
        price = 100000,
        class = 'sports'
	},
    flashgt = {
        label = 'Flash GT',
       model =  'flashgt',
        price = 100000,
        class = 'sports'
	},
    furoregt = {
        label = 'Furore GT',
        model =  'furoregt',
        price = 100000,
        class = 'sports'
	},
    fusilade = {
        label = 'Fusilade',
        model =  'fusilade',
        price = 25000,
        class = 'sports'
	},
    Futo = {
        label = 'Futo',
        model = 'Futo',
        price = 60000,
        class = 'sports'
	},
    gb200 = {
        label = 'GB200',
        model = 'gb200',
        price = 100000,
        class = 'sports'
	},
    hotring = {
        label = 'Hotring Sabre',
        model =  'hotring',
        price = 75000,
        class = 'sports'
	},
    imorgon = {
        label = 'Overflod Imorgon',
        model =  'imorgon',
        price = 200000,
        class = 'sports'
	},
    Italigto = {
        label = 'Itali GTA Dinka',
        model =  'Italigto',
        price = 200000,
        class = 'sports'
	},
    jester = {
        label = 'Jester',
        model = 'jester',
        price = 150000,
        class = 'sports'
	},
    jester2 = {
        label = 'Jester(Racecar)',
        model =  'jester2',
        price = 200000,
        class = 'sports'
	},
    khamelion = {
        label = 'Khamelion',
        model =  'khamelion',
        price = 100000,
        class = 'sports'
	},
    komoda = {
        label = 'Lampadati Komoda',
        model = 'komoda',
        price = 100000,
        class = 'sports'
	},
    kuruma = {
        label = 'Kuruma',
        model = 'kuruma',
        price = 75000,
        class = 'sports'
	},
    lynx = {
        label = 'Lynx',
        model = 'lynx',
        price = 100000,
        class = 'sports'
	},
    massacro = {
        label = 'Massacro',
        model =  'massacro',
        price = 115000,
        class = 'sports'
	},
    massacro2 = {
        label = 'Massacro(Racecar)',
        model =  'massacro2',
        price = 120000,
        class = 'sports'
	},
    neon = {
        label = 'Neon Plister',
        model = 'neon',
        price = 400000,
        class = 'sports'
	},
    ninef = {
        label = '9F',
        model = 'ninef',
        price = 150000,
        class = 'sports'
	},
    ninef2 = {
        label = '9F Cabrio',
        model = 'ninef2',
        price = 150000,
        class = 'sports'
	},
    omnis = {
        label = 'Omnis',
        model = 'omnis',
        price = 100000,
        class = 'sports'
	},
    oracle = {
        label = 'Oracle',
        model = 'oracle',
        price = 40000,
        class = 'sports'
	},
    pariah = {
        label = 'Pariah',
        model = 'pariah',
        price = 155000,
        class = 'sports'
	},
    penumbra = {
        label = 'Penumbra',
        model =  'penumbra',
        price = 25000,
        class = 'sports'
	},
    raiden = {
        label = 'Raiden Coil',
        model = 'raiden',
        price = 200000,
        class = 'sports'
	},
    rapidgt = {
        label = 'Rapid GT',
        model =  'rapidgt',
        price = 70000,
        class = 'sports'
	},
    rapidgt2 = {
        label = 'Rapid GT Convertible',
        model =  'rapidgt2',
        price = 70000,
        class = 'sports'
	},
    raptor = {
        label = 'Raptor',
        model = 'raptor',
        price = 25000,
        class = 'sports'
	},
    ruston = {
        label = 'Ruston',
        model = 'ruston',
        price = 160000,
        class = 'sports'
	},
    schafter3 = {
        label = 'Schafter V12',
        model =  'schafter3',
        price = 65000,
        class = 'sports'
	},
    schafter4 = {
        label = 'Schafter LWB',
        model =  'schafter4',
        price = 55000,
        class = 'sports'
	},
    schlagen = {
        label = 'Schlagen GT Benefactor',
        model =  'schlagen',
        price = 150000,
        class = 'sports'
	},
    schwarzer = {
        label = 'Schwartzer',
        model =  'schwarzer',
        price = 100000,
        class = 'sports'
	},
    sentinel3 = {
        label = 'Sentinel3',
        model =  'sentinel3',
        price = 100000,
        class = 'sports'
	},
    seven70 = {
        label = 'Seven 70',
        model =  'seven70',
        price = 200000,
        class = 'sports'
	},
    specter = {
        label = 'Specter Dewbauchee',
        model =  'specter',
        price = 200000,
        class = 'sports'
	},
    specter2 = {
        label = 'Specter Custom Dewbauchee',
        model =  'specter2',
        price = 250000,
        class = 'sports'
	},
    streiter = {
        label = 'Streiter',
        model =  'streiter',
        price = 40000,
        class = 'sports'
	},
    streiter2 = {
        label = 'Streiter Sport',
        model =  'streiter2',
        price = 50000,
        class = 'sports'
	},
    sugoi = {
        label = 'Dinka Sugoi',
        model = 'sugoi',
        price = 50000,
        class = 'sports'
	},
    surano = {
        label = 'Surano',
        model = 'surano',
        price = 40000,
        class = 'sports'
	},
    tampa2 = {
        label = 'Drift Tampa',
        model = 'tampa2',
        price = 80000,
        class = 'sports'
	},
    tropos = {
        label = 'Tropos',
        model = 'tropos',
        price = 100000,
        class = 'sports'
	},
    verlierer2 = {
        label = 'Verlierer',
        model =  'verlierer2',
        price = 500000,
        class = 'sports'
    },
    comet7 = {
        label = 'Comet S2 Cabrio',
        model =  'comet7',
        price = 100000,
        class = 'sports'
    },
    comet6 = {
        label = 'Comet S2',
        model =  'comet6',
        price = 300000,
        class = 'sports'
    },
    calico = {
        label = 'Calico',
        model =  'calico',
        price = 300000,
        class = 'sports'
    },
    cypher = {
        label = 'Cypher',
        model =  'cypher',
        price = 300000,
        class = 'sports'
    },
    dominator7 = {
        label = 'Dominator Asp',
        model =  'dominator7',
        price = 300000,
        class = 'sports'
    },
    euros = {
        label = 'Euros',
        model =  'euros',
        price = 300000,
        class = 'sports'
    },
    growler = {
        label = 'Growler',
        model =  'growler' ,
        price = 300000,
        class = 'sports'
    },
    jester4 = {
        label = 'Jester RR',
        model =  'jester4',
        price = 300000,
        class = 'sports'
    },
    previon = {
        label = 'Previon',
        model =  'previon',
        price = 300000,
        class = 'sports'
    },
    remus = {
        label = 'Remus',
        model =  'remus',
        price = 300000,
        class = 'sports'
    },
    rt3000 = {
        label = 'Rt 3000',
        model =  'rt3000',
        price = 300000,
        class = 'sports'
    },
    sultan3 = {
        label = 'Sultan Rs Classic',
        model =  'sultan3',
        price = 300000,
        class = 'sports'
    },
    vectre = {
        label = 'Vectre',
        model =  'vectre',
        price = 300000,
        class = 'sports'
    },
    warrener2 = {
        label = 'Warrener Hkr',
        model =  'warrener2',
        price = 300000,
        class = 'sports'
    },
    zr350 = {
        label = 'Zr 350',
        model =  'zr350',
        price = 300000,
        class = 'sports'
    }
} 

Pdm.Vehicles_list.muscle = {
    blade = {
        label = 'Blade Vapid',
        model = 'blade',
        price = 20000,
        class = 'muscle'
    },
	buccaneer = {
        label = 'Buccaneer Albany',
        model = 'buccaneer',
        price = 12000,
        class = 'muscle'
    },
	buccaneer2 = {
        label = 'Buccaneer Custom Albany',
        model = 'buccaneer2',
        price = 20000,
        class = 'muscle'
    },
	chino = {
        label = 'Chino Vapid',
        model = 'chino',
        price = 9000,
        class = 'muscle'
    },
	chino2 = {
        label = 'Chino Custom Vapid',
        model = 'chino2',
        price = 19000,
        class = 'muscle'
    },
	clique = {
        label = 'Clique',
        model = 'clique',
        price = 40000,
        class = 'muscle'
    },
	coquette3 = {
        label = 'Coquette BlackFin',
        model = 'coquette3',
        price = 65000,
        class = 'muscle'
    },
	deviant = {
        label = 'Deviant',
        model = 'deviant',
        price = 30000,
        class = 'muscle'
    },
	dominator = {
        label = 'Dominator',
        model = 'dominator',
        price = 100000,
        class = 'muscle'
    },
	dominator2 = {
        label = 'Pisswasser Dominator',
        model = 'dominator2',
        price = 115000,
        class = 'muscle'
    },
	dominator3 = {
        label = 'Dominator GTX',
        model = 'dominator3',
        price = 115000,
        class = 'muscle'
    },
	duke3 = {
        label = 'Imponte Duke Classic',
        model = 'duke3',
        price = 75000,
        class = 'muscle'
    },
	dukes = {
        label = 'Dukes',
        model = 'dukes',
        price = 60000,
        class = 'muscle'
    },
	ellie = {
        label = 'Ellie',
        model = 'ellie',
        price = 85000,
        class = 'muscle'
    },
	faction = {
        label = 'Faction',
        model = 'faction',
        price = 20000,
        class = 'muscle'
    },
	faction2 = {
        label = 'Faction Custom',
        model = 'faction2',
        price = 25000,
        class = 'muscle'
    },
	gauntlet = {
        label = 'Gauntlet',
        model = 'gauntlet',
        price = 50000,
        class = 'muscle'
    },
	gauntlet2 = {
        label = 'Redwood Gauntlet',
        model = 'gauntlet2',
        price = 60000,
        class = 'muscle'
    },
	gauntlet4 = {
        label = 'Bravado Gauntlet SRT',
        model = 'gauntlet4',
        price = 75000,
        class = 'muscle'
    },
	gauntlet5 = {
        label = 'Bravado Gauntlet 70',
        model = 'gauntlet5',
        price = 95000,
        class = 'muscle'
    },
	hermes = {
        label = 'Hermes',
        model = 'hermes',
        price = 50000,
        class = 'muscle'
    },
	hotknife = {
        label = 'Hotknife',
        model = 'hotknife',
        price = 55000,
        class = 'muscle'
    },
	hustler = {
        label = 'Hustler',
        model = 'hustler',
        price = 45000,
        class = 'muscle'
    },
	impaler = {
        label = 'Impaler',
        model = 'impaler',
        price = 35000,
        class = 'muscle'
    },
	manana2 = {
        label = 'Albany Manana CL',
        model = 'manana2',
        price = 47500,
        class = 'muscle'
    },
	nightshade = {
        label = 'Nightshade',
        model = 'nightshade',
        price = 65000,
        class = 'muscle'
    },
	peyote2 = {
        label = 'Vapid Peyote Drag',
        model = 'peyote2',
        price = 65000,
        class = 'muscle'
    },
	phoenix = {
        label = 'Phoenix Imponte',
        model = 'phoenix',
        price = 42000,
        class = 'muscle'
    },
	picador = {
        label = 'Picador Marshall',
        model = 'picador',
        price = 19000,
        class = 'muscle'
    },
	ratloader = {
        label = 'Rat-Loader',
        model = 'ratloader',
        price = 9000,
        class = 'muscle'
    },
	ratloader2 = {
        label = 'Rat-Truck',
        model = 'ratloader2',
        price = 18000,
        class = 'muscle'
    },
	ruiner = {
        label = 'Ruiner',
        model = 'ruiner',
        price = 32000,
        class = 'muscle'
    },
	sabregt = {
        label = 'Sabre Turbo Declasse',
        model = 'sabregt',
        price = 14000,
        class = 'muscle'
    },
	sabregt2 = {
        label = 'Sabre Turbo Custom Declasse',
        model = 'sabregt2',
        price = 20000,
        class = 'muscle'
    },
	slamvan = {
        label = 'Slamvan',
        model = 'slamvan',
        price = 15000,
        class = 'muscle'
    },
	slamvan3 = {
        label = 'Slam Van',
        model = 'slamvan3',
        price = 30000,
        class = 'muscle'
    },
	stalion = {
        label = 'Stallion',
        model = 'stalion',
        price = 15000,
        class = 'muscle'
    },
	stalion2 = {
        label = 'Declasse Burger Shot Stalion',
        model = 'stalion2',
        price = 200000,
        class = 'muscle'
    },
	tampa = {
        label = 'Tampa',
        model = 'tampa',
        price = 35000,
        class = 'muscle'
    },
	tulip = {
        label = 'Tulip',
        model = 'tulip',
        price = 25000,
        class = 'muscle'
    },
	vamos = {
        label = 'Vamos',
        model = 'vamos',
        price = 55000,
        class = 'muscle'
    },
	vigero = {
        label = 'Vigero',
        model = 'vigero',
        price = 19000,
        class = 'muscle'
    },
	virgo = {
        label = 'Virgo',
        model = 'virgo',
        price = 15000,
        class = 'muscle'
    },
	virgo2 = {
        label = 'Virgo Classic Custom',
        model = 'virgo2',
        price = 50000,
        class = 'muscle'
    },
	virgo3 = {
        label = 'Virgo Classic',
        model = 'virgo3',
        price = 30000,
        class = 'muscle'
    },
	voodoo = {
        label = 'Voodoo Custom',
        model = 'voodoo',
        price = 12500,
        class = 'muscle'
    },
	voodoo2 = {
        label = 'Voodoo',
        model = 'voodoo2',
        price = 6000,
        class = 'muscle'
    },
	yosemite = {
        label = 'Yosemite',
        model = 'yosemite',
        price = 35000,
        class = 'muscle'
    },
    dominator8 = {
        label = 'Dominator Gtt',
        model =  'dominator8',
        price = 300000,
        class = 'sports'
    },
    slamtruck = {
        label = 'Slam Truck',
        model = 'slamtruck',
        price = 90000,
        class = 'muscle'
    },
}

Pdm.Vehicles_list.coupes = {
    cogcabrio = {
        label = 'Cognoscenti Cabrio',
        model = 'cogcabrio',
        price = 65000,
        class = 'coupes'
    },
	exemplar = {
        label = 'Exemplar',
        model = 'exemplar',
        price = 100000,
        class = 'coupes'
    },
	f620 = {
        label = 'F620',
        model = 'f620',
        price = 65000,
        class = 'coupes'
    },
	felon = {
        label = 'Felon',
        model = 'felon',
        price = 65000,
        class = 'coupes'
    },
	felon2 = {
        label = 'Felon GT',
        model = 'felon2',
        price = 75000,
        class = 'coupes'
    },
	jackal = {
        label = 'Jackal',
        model = 'jackal',
        price = 75000,
        class = 'coupes'
    },
	oracle2 = {
        label = 'Oracle XS',
        model = 'oracle2',
        price = 55000,
        class = 'coupes'
    },
	penumbra2 = {
        label = 'Maibatsu Plenumbra',
        model = 'penumbra2',
        price = 200000,
        class = 'coupes'
    },
	sentinel = {
        label = 'Sentinel Turbo XR',
        model = 'sentinel',
        price = 100000,
        class = 'coupes'
    },
	sentinel2 = {
        label = 'Sentinel XS',
        model = 'sentinel2',
        price = 75000,
        class = 'coupes'
    },
	windsor = {
        label = 'Windsor',
        model = 'windsor',
        price = 65000,
        class = 'coupes'
    },
	windsor2 = {
        label = 'Windsor Drop',
        model = 'windsor2',
        price = 65000,
        class = 'coupes'
    },
	zion = {
        label = 'Zion',
        model = 'zion',
        price = 55000,
        class = 'coupes'
    },
	zion2 = {
        label = 'Zion Cabrio',
        model = 'zion2',
        price = 60000,
        class = 'coupes'
    },
	zion3 = {
        label = 'Ubermacht Zion CI',
        model = 'zion3',
        price = 55000,
        class = 'coupes'
    }
}

Pdm.Vehicles_list.suvs = {
    baller = {
        label = 'Baller',
        model = 'baller',
        price = 28000,
        class = 'suvs'
    },
	baller2 = {
        label = 'Baller',
        model =  'baller2',
        price = 38000,
        class = 'suvs'
    },
	baller3 = {
        label = 'Baller Sport',
        model =  'baller3',
        price = 60000,
        class = 'suvs'
    },
	baller4 = {
        label = 'Baller LE LWB',
        model =  'baller4',
        price = 70000,
        class = 'suvs'
    },
	bjxl = {
        label = 'Beejay XL',
        model = 'bjxl',
        price = 22000,
        class = 'suvs'
    },
	cavalcade = {
        label = 'Cavalcade',
        model =  'cavalcade',
        price = 26000,
        class = 'suvs'
    },
	cavalcade2 = {
        label = 'Cavalcade ESV',
        model =  'cavalcade2',
        price = 34000,
        class = 'suvs'
    },
	contender = {
        label = 'Contender Vapid',
        model =  'contender',
        price = 55000,
        class = 'suvs'
    },
	dubsta = {
        label = 'Dubsta',
        model = 'dubsta',
        price = 55000,
        class = 'suvs'
    },
	dubsta2 = {
        label = 'Dubsta Luxuary',
        model =  'dubsta2',
        price = 65000,
        class = 'suvs'
    },
	fq2 = {
        label = 'FQ 2 Fathom',
        model = 'fq2',
        price = 45000,
        class = 'suvs'
    },
	granger = {
        label = 'Grabger',
        model =  'granger',
        price = 40000,
        class = 'suvs'
    },
	gresley = {
        label = 'Gresley',
        model =  'gresley',
        price = 60000,
        class = 'suvs'
    },
	guardian = {
        label = 'Guardian Vapid',
        model =  'guardian',
        price = 80000,
        class = 'suvs'
    },
	habanero = {
        label = 'Habanero',
        model =  'habanero',
        price = 13000,
        class = 'suvs'
    },
	hellion = {
        label = 'Annis Hellion',
        model =  'hellion',
        price = 75000,
        class = 'suvs'
    },
	huntley = {
        label = 'Huntley S',
        model =  'huntley',
        price = 60000,
        class = 'suvs'
    },
	landstalker = {
        label = 'Landstalker',
        model =  'landstalker',
        price = 25000,
        class = 'suvs'
    },
	landstalker2 = {
        label = 'Landstalker XL',
        model =  'landstalker2',
        price = 45000,
        class = 'suvs'
    },
	mesa = {
        label = 'Mesa',
        model = 'mesa',
        price = 25000,
        class = 'suvs'
    },
	novak = {
        label = 'Lampadati Novak',
        model = 'novak',
        price = 100000,
        class = 'suvs'
    },
	patriot = {
        label = 'Patriot',
        model =  'patriot',
        price = 65000,
        class = 'suvs'
    },
	patriot2 = {
        label = 'Patriot Stretch',
        model =  'patriot2',
        price = 100000,
        class = 'suvs'
    },
	radi = {
        label = 'Radius',
        model = 'radi',
        price = 9000,
        class = 'suvs'
    },
	rebla = {
        label = 'Rebla GTS',
        model = 'rebla',
        price = 80000,
        class = 'suvs'
    },
	rocoto = {
        label = 'Rocoto',
        model = 'rocoto',
        price = 60000,
        class = 'suvs'
    },
	seminole = {
        label = 'Seminole',
        model =  'seminole',
        price = 15000,
        class = 'suvs'
    },
	serrano = {
        label = 'Serrano',
        model =  'serrano',
        price = 18000,
        class = 'suvs'
    },
	Toros = {
        label = 'Toros Pegassi',
        model = 'Toros',
        price = 200000,
        class = 'suvs'
    },
	xls = {
        label = 'XLS',
        model = 'xls',
        price = 25000,
        class = 'suvs'
    },
    astron = {
        label = 'ASTRON',
        model = 'Astron',
        price = 125000,
        class = 'suvs'
    },
    baller7 = {
        label = 'BALLER7',
        model = 'Baller ST',
        price = 125000,
        class = 'suvs'
    },
    iwagen = {
        label = 'I-Wagen',
        model = 'iwagen',
        price = 125000,
        class = 'suvs'
    },
    squaddie = {
        label = 'Squaddie',
        model = 'squaddie',
        price = 155000,
        class = 'suvs'
    },
    winky = {
        label = 'Winky',
        model = 'winky',
        price = 135000,
        class = 'suvs'
    }
}

Pdm.Vehicles_list.offroad = {
    bfinjection = {
        label = 'Bf Injection',
        model = 'bfinjection',
        price = 6000,
        class = 'offroad'
    },
	bifta = {
        label = 'Bifta',
        model = 'bifta',
        price = 22000,
        class = 'offroad'
    },
	blazer = {
        label = 'Blazer',
        model = 'blazer',
        price = 5500,
        class = 'offroad'
    },
	blazer2 = {
        label = 'Nagasaki Blazer ATV',
        model = 'blazer2',
        price = 12500,
        class = 'offroad'
    },
	blazer3 = {
        label = 'Blazer Hot Rod',
        model = 'blazer3',
        price = 12000,
        class = 'offroad'
    },
	blazer4 = {
        label = 'Blazer Sport',
        model = 'blazer4',
        price = 10000,
        class = 'offroad'
    },
	boattrailer = {
        label = 'Remorque pour Bateau',
        model = 'boattrailer',
        price = 15000,
        class = 'offroad'
    },
	bodhi2 = {
        label = 'Bodhi Canis',
        model = 'bodhi2',
        price = 9000,
        class = 'offroad'
    },
	brawler = {
        label = 'Brawler',
        model = 'brawler',
        price = 35000,
        class = 'offroad'
    },
	cara = {
        label = 'Vapid Cara',
        model = 'cara',
        price = 50000,
        class = 'offroad'
    },
	caracara2 = {
        label = 'Vapid Caracara',
        model = 'caracara2',
        price = 65000,
        class = 'offroad'
    },
	dloader = {
        label = 'DuneLoader Bravado',
        model = 'dloader',
        price = 8500,
        class = 'offroad'
    },
	dubsta3 = {
        label = 'Bubsta 6x6',
        model = 'dubsta3',
        price = 85000,
        class = 'offroad'
    },
	dune = {
        label = 'Dune Buggy',
        model = 'dune',
        price = 9500,
        class = 'offroad'
    },
	everon = {
        label = 'Karim Everon',
        model = 'everon',
        price = 75000,
        class = 'offroad'
    },
	Freecrawler = {
        label = 'Freecrawler',
        model = 'Freecrawler',
        price = 60000,
        class = 'offroad'
    },
	kamacho = {
        label = 'Kamacho',
        model = 'kamacho',
        price = 115000,
        class = 'offroad'
    },
	outlaw = {
        label = 'Nagasaki Outlaw',
        model = 'outlaw',
        price = 65000,
        class = 'offroad'
    },
	rebel = {
        label = 'Rebel Rouiller',
        model = 'rebel',
        price = 9500,
        class = 'offroad'
    },
	rebel2 = {
        label = 'Rebel',
        model = 'rebel2',
        price = 17000,
        class = 'offroad'
    },
	riata = {
        label = 'riata',
        model = 'riata',
        price = 40000,
        class = 'offroad'
    },
	sadler = {
        label = 'Vapid Sadler',
        model = 'sadler',
        price = 16000,
        class = 'offroad'
    },
	sandking = {
        label = 'Sandking',
        model = 'sandking',
        price = 40000,
        class = 'offroad'
    },
	seminole2 = {
        label = 'Canis Seminole 4x4',
        model = 'seminole2',
        price = 45000,
        class = 'offroad'
    },
	trailersmawll = {
        label = 'Remorque pour auto',
        model = 'trailersmawll',
        price = 25000,
        class = 'offroad'
    },
	trophytruck = {
        label = 'Trophy Truck Vapid',
        model = 'trophytruck',
        price = 175000,
        class = 'offroad'
    },
	trophytruck2 = {
        label = 'Desert Trail',
        model = 'trophytruck2',
        price = 150000,
        class = 'offroad'
    },
	vagrant = {
        label = 'Vagrant',
        model = 'vagrant',
        price = 75000,
        class = 'offroad'
    },
	yosemite3 = {
        label = 'Declasse Yosemite FX',
        model = 'yosemite3',
        price = 80000,
        class = 'offroad'
    },
	youga3 = {
        label = 'Bravado Youga XLT',
        model = 'youga3',
        price = 13000,
        class = 'offroad'
    },
    youga4 = {
        label = 'Youga Custom',
        model = 'youga4',
        price = 32000,
        class = 'offroad'
    }
}

Pdm.Vehicles_list.utility = {
    benson = {
        label = 'Benson',
        model = 'benson',
        price = 60000,
        class = 'utility'
    },

    boxville = {
        label = 'Boxville utility',
        model = 'boxville',
        price = 75000,
        class = 'utility'
    },

    boxville2 = {
        label = 'Boxville Cargo',
        model = 'boxville2',
        price = 75000,
        class = 'utility'
    },

    boxville3 = {
        label = 'Boxville HLabs',
        model = 'boxville3',
        price = 75000,
        class = 'utility'
    },

    boxville4 = {
        label = 'Boxville PostOP',
        model = 'boxville4',
        price = 75000,
        class = 'utility'
    },

    camper = {
        label = 'Camper',
        model = 'camper',
        price = 40000,
        class = 'utility'
    },

    hauler = {
        label = 'Hauler',
        model = 'hauler',
        price = 100000,
        class = 'utility'
    },

    journey = {
        label = 'Journey',
        model = 'journey',
        price = 9000,
        class = 'utility'
    },

    mule = {
        label = 'Mule Standard',
        model = 'mule',
        price = 100000,
        class = 'utility'
    },

    mule2 = {
        label = 'Mule XLT S',
        model = 'mule2',
        price = 100000,
        class = 'utility'
    },

    mule3 = {
        label = 'Mule Luxury',
        model = 'mule3',
        price = 100000,
        class = 'utility'
    },

    phatom = {
        label = 'Phantom',
        model = 'phatom',
        price = 100000,
        class = 'utility'
    },

    pounder = {
        label = 'Pounder 40ft',
        model = 'pounder',
        price = 900000,
        class = 'utility'
    },

    vetir = {
        label = 'Vetir',
        model = 'vetir',
        price = 150000,
        class = 'utility'
    },
}

Pdm.Vehicles_list.vans = {
    bison = {
        label = 'Bison',
        model = 'bison',
        price = 18000,
        class = 'vans'
    },

	bobcatxl = {
        label = 'Bobcat XL',
        model = 'bobcatxl',
        price = 13000,
        class = 'vans'
    },

	burrito3 = {
        label = 'Burrito',
        model = 'burrito3',
        price = 15000,
        class = 'vans'
    },

	gburrito = {
        label = 'Gang Burrito',
        model = 'gburrito',
        price = 15000,
        class = 'vans'
    },

	gburrito2 = {
        label = 'Burrito Gang',
        model = 'gburrito2',
        price = 15000,
        class = 'vans'
    },

	minivan = {
        label = 'Minivan',
        model = 'minivan',
        price = 11000,
        class = 'vans'
    },

	moonbeam = {
        label = 'Moonbeam',
        model = 'moonbeam',
        price = 16000,
        class = 'vans'
    },

	moonbeam2 = {
        label = 'Moonbeam Custom',
        model = 'moonbeam2',
        price = 24000,
        class = 'vans'
    },

	nspeedo = {
        label = 'Speedo Transit',
        model = 'nspeedo',
        price = 75000,
        class = 'vans'
    },

	paradise = {
        label = 'Paradise',
        model = 'paradise',
        price = 35000,
        class = 'vans'
    },

	rumpo = {
        label = 'Rumpo Bravado',
        model = 'rumpo',
        price = 17000,
        class = 'vans'
    },

	Rumpo3 = {
        label = 'Rumpo Custom Trail Bravado',
        model = 'Rumpo3',
        price = 75000,
        class = 'vans'
    },

	sandking2 = {
        label = 'Sandking SWB',
        model = 'sandking2',
        price = 35000,
        class = 'vans'
    },

	Speedo = {
        label = 'Speedo',
        model = 'Speedo',
        price = 11000,
        class = 'vans'
    },

	surfer = {
        label = 'Surfer',
        model = 'surfer',
        price = 20000,
        class = 'vans'
    },

	youga2 = {
        label = 'Youga Classique Bravado',
        model = 'youga2',
        price = 13500,
        class = 'vans'
    }
}