reviewDet = LOAD '/yelpdatafall/review/review.csv' USING PigStorage('^') AS (revId, userId, busId, stars:float);
busDet = LOAD '/yelpdatafall/business/business.csv' USING PigStorage('^') AS (busId, address, categories);

txCompanies = FILTER busDet BY (address MATCHES '.*TX.*');
compDetails = JOIN txCompanies BY busId, reviewDet BY busId;
distComp = DISTINCT compDetails;
grpBusIds = GROUP distComp BY txCompanies::busId;
busIdStars = FOREACH grpBusIds GENERATE group as busId, COUNT(distComp.stars) as stars;
dump busIdStars;
