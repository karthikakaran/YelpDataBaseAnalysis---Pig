busDet = LOAD '/yelpdatafall/business/business.csv' USING PigStorage('^') AS (busId, address, categories);
reviewDet = LOAD '/yelpdatafall/review/review.csv' USING PigStorage('^') AS (revId, userId, busId, stars:float);

idStar = FOREACH reviewDet GENERATE busId, stars;
idStarGrp = Group idStar BY busId;
avgStar = FOREACH idStarGrp GENERATE group, AVG(idStar.stars) AS busId;
descOrd = ORDER avgStar by $1 DESC;
top10Ratings = LIMIT descOrd 10;

top10 = JOIN busDet BY busId, top10Ratings BY $0;
result = FOREACH top10 GENERATE $0, $1, $2, $4;
dump result;
