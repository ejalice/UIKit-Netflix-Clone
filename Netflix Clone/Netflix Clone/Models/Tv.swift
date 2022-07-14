//
//  Tv.swift
//  Netflix Clone
//
//  Created by eunji on 2022/07/14.
//

import Foundation

struct TrendingTvResponse: Codable {
    let results: [Tv]
}

struct Tv: Codable {
    let id: Int
    let media_type: String?
    let title: String?
    let original_name: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}
//adult = 0;
//"backdrop_path" = "/rlCRM7U5g2hcU1O8ylGcqsMYHIP.jpg";
//"first_air_date" = "2022-06-08";
//"genre_ids" =             (
//    10765,
//    10759,
//    35
//);
//id = 92782;
//"media_type" = tv;
//name = "Ms. Marvel";
//"origin_country" =             (
//    US
//);
//"original_language" = en;
//"original_name" = "Ms. Marvel";
//overview = "A great student, avid gamer, and voracious fan-fic scribe, Kamala Khan has a special affinity for superheroes, particularly Captain Marvel. However, she struggles to fit in at home and at school \U2014 that is, until she gets superpowers like the heroes she\U2019s always looked up to. Life is easier with superpowers, right?";
//popularity = "2773.838";
//"poster_path" = "/cdkyMYdu8ao26XOBvilNzLneUg1.jpg";
//"vote_average" = "7.337";
//"vote_count" = 316;
