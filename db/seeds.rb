# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


ts = ["Battle by the Beach",
"Ara Kumjian Invite",
"Beresford Invite",
"Carlsbad Invite",
"Carter Invite",
"Ceres Invite",
"Chester Invite",
"Chowchilla Duals",
"Cossarek Classic",
"Doc Lippman Duals",
"Doc Peterson Invite",
"Dos Palos Invite",
"El Dorado Invite",
"Grizzly Duals",
"Granite Bay",
"Faultine Duals",
"John Bright Duals/Tourney",
"Larry Nelson Classic",
"McNair Invite",
"Rick Swift Memorial Ironman",
"Newbury Park Invite",
"Peninsula Invite",
"Pete Duca Invite",
"Rumble for the Rig",
"Vista Tourney",
"Warrior Invite",
"American Canyon Classic",
"Andrew Pena Invite",
"Bay Area Invite",
"Bear Creek Invite",
"Black Living Water",
"Chukchansi Invite",
"Clovis West Shootout",
"Coyote Classic",
"Curt Mettler Invite",
"Eagle Invite",
"Edison Beach Bash",
"Golden Legends Tourney",
"Green and Gold",
"Hamada Invite",
"Hawks Nest Invite",
"James Riddle Classic",
"Jesse Cruz Memorial",
"Marauder Invite",
"Nighthawk Duals",
"Northeast Classic",
"Run to Danger",
"Scott Davis Invite",
"Temescal Duals",
"Tustin Invite",
"Walsh Ironman",
"Webber Lawson",
"Coyote Classic",
"Al Dingwall",
"American River Classic",
"Bill Martell Invite",
"Brute Rumble",
"California Classic",
"Chris Savedra",
"Colton X-Mas Classic",
"Downey 32-Way",
"Ed Springs Classic",
"El Cajon Invite",
"Folsom Jailbreak Duals",
"Fort Bragg Tourney",
"Grans Pass Winter KO",
"Healdsburg Duals",
"Las Vegas Holiday Classic",
"Mann Classic",
"Marty Manges Invite",
"Morning Star Invite",
"Napa Valley Classic",
"Nick Buzolich Classic",
"Rebel Classic",
"Reno TOC",
"West Coast Classic",
"Vista Murrieta Duals",
"Zinkin Classic",
"Deliddo Classic",
"Mike Tamana Invite",
"Lou Bronzan Invite",
"Black Watch",
"Calif. Coast Classic",
"Cerritos TOC",
"ASICS So Cal Challenge",
"No Guts, No Glory",
"Rumble at the Lake",
"Santiago Shark Tank",
"The Clash XV",
"Sierra Nevada Classic",
"The Bash, Don Olson",
"Beaumont Tourney",
"Dragon Duals",
"McKinleyville",
"Gordon Hay Invite",
"Oakmont Viking Crusade",
"Pirate Invitational",
"Willemstein Invite",
"Apple Cider Classic",
"ASICS So Cal Challenge",
"Arroyo Classic",
"Bianchini Memorial",
"Bulldog Classic",
"Capital City Classic",
"Dennis Jensen Invite",
"Dinuba Invite",
"Doc Buchanan",
"El Camino Invite",
"Hilltop Duals",
"Holiday Classic",
"Inland Empire TOC",
"Joe Rios Memorial",
"Juan Enriquez Memorial",
"Lancers Invite",
"Mat Classic",
"Nogales SuperChamps",
"Nor Cal Beast",
"NY Revolution",
"Riverside County",
"Sam DeJohn Invite",
"San Bernadino Champ.",
"San Ysidro Tourney",
"San Ramon Valley Invite",
"SBC Tourney",
"The Dream",
"Tri-Titan Classic",
"Amaral Memorial",
"Anaheim Tourney",
"Armijo Invitational",
"Bert Mar Invite",
"Bridgetown Throwdown",
"Clayton Valley Invite",
"Deets Winslow Invite",
"Five Counties",
"Jim Root Classic",
"Kern County Invite",
"Kroppman Memorial",
"Mark Fuller Invite",
"Redwood Invitational",
"Santa Ynez Tourney",
"Snowden Memorial",
"Sutter Lions Invite",
"Temecula Valley Invite",
"Tim Brown Memorial",
"Troy Invite",
"Westside Classic",
"Centennial Invite",
"CIT",
"Dick Comly",
"Jaguar Classic",
"Jason White Memorial",
"Kermit Bankson Invite",
"King of the Mat",
"LA City Throwdown",
"Laguna Hills Invite",
"Mid Cals",
"Millikan Invite",
"Montclair Classic",
"North Coast Classic",
"Raul Huerta Memorial",
"San Clemente Rotary",
"True Wrestler",
"Central Valley Invite",
"Corning Invite",
"Dawn 2 Dusk",
"El Dorado Trojan War",
"Highland Invite",
"Holtville Rotary",
"Julie Leonard Memorial",
"Lou Encalada Invite",
"Overfelt Classic",
"Pitman Rumble in the Jungle",
"Placer Duals",
"Puma Classic",
"South Bay Invite",
"Mission San Jose",
"The Pound",
"Colt Invitational",
"Redwood Empire Classic",
"Robert Jenkins Memorial",
"Tiger Invitational"
]



  wr.each do |w|
    w.bouts.each do |b|
      if b.tourney_place && b.tourney_place > 0
        unless @tourney_results.include?([b.tourney_name, b.tourney_place])
          @tourney_results << [b.tourney_name, b.tourney_place]
        end
      end
    end
    if @tourney_results != nil
    if @tourney_results[0]
      w.t1_name = @tourney_results[0][0] 
      w.t1_place = @tourney_results[0][1] 
    end
    if @tourney_results[1]  
      w.t2_name = @tourney_results[1][0] 
      w.t2_place = @tourney_results[1][1] 
      end
    if @tourney_results[2]
      w.t3_name = @tourney_results[2][0] 
      w.t3_place = @tourney_results[2][1] 
    end
    if @tourney_results[3]
      w.t4_name = @tourney_results[3][0] 
      w.t4_place = @tourney_results[3][1] 
    end
    if @tourney_results[4]
      w.t5_name = @tourney_results[4][0] 
      w.t5_place = @tourney_results[4][1] 
    end
    if @tourney_results[5]
      w.t6_name = @tourney_results[5][0] 
      w.t6_place = @tourney_results[5][1] 
    end
    if @tourney_results[6]
      w.t7_name = @tourney_results[6][0] 
      w.t7_place = @tourney_results[6][1] 
    end
    if @tourney_results[7]
      w.t8_name = @tourney_results[7][0] 
      w.t8_place = @tourney_results[7][1] 
    end
  end
    w.save
    @tourney_results = []
  end



