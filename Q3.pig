reviewDet = LOAD '/yelpdatafall/review/review.csv' USING PigStorage('^') AS (revId, userId, busId, stars:float);
busDet = LOAD '/yelpdatafall/business/business.csv' USING PigStorage('^') AS (busId, address, categories);

stCompanies = FILTER busDet BY (address MATCHES '.*Standford.*');
compDetails = JOIN stCompanies BY busId, reviewDet BY busId;

userIdStars = FOREACH compDetails GENERATE $4 as userId, $6 as stars;
dump userIdStars;
