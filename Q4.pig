reviewDet = LOAD '/yelpdatafall/review/review.csv' USING PigStorage('^') AS (revId, userId, busId, stars:float);
grpUsers = GROUP reviewDet BY userId;
countStars = FOREACH grpUsers GENERATE group AS userId, COUNT(reviewDet.stars) AS cntStars;
descOrder = ORDER countStars BY cntStars DESC;
top10Users = LIMIT descOrder 10;
userDet = LOAD '/yelpdatafall/user/user.csv' USING PigStorage('^') AS (userId, name, url);
userdetails = JOIN userDet BY userId, top10Users by userId;
dump userdetails.$0, userdetails.$1;
