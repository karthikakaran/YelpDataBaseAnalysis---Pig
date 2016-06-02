reviewDet = LOAD '/yelpdatafall/review/review.csv' USING PigStorage('^') AS (revId, userId, busId, stars:float);
userDet = LOAD '/yelpdatafall/user/user.csv' USING PigStorage('^') AS (userId, name, url);

userName = FILTER userDet BY (name MATCHES '.*matt h.*');
userdetails = JOIN userName BY userId, reviewDet BY userId;

userIdStars = FOREACH userdetails GENERATE $0 as userId, $6 as stars;

grpUserId = GROUP userIdStars BY userId;
result = FOREACH grpUserId GENERATE group, AVG(userIdStars.stars); 
dump result;

