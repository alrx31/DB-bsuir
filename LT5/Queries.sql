SELECT 
    p.Title AS producer_title,
    COUNT(d.DreamId) AS dream_count
FROM Producer p
JOIN Dream d ON p.ProducerId = d.ProducerId
GROUP BY p.Title
HAVING COUNT(d.DreamId) >= (
    SELECT AVG(dream_count)
    FROM (
        SELECT COUNT(DreamId) AS dream_count
        FROM Dream
        GROUP BY ProducerId
    ) AS counts
);



SELECT 
    u.Name,
    AVG(r.Rating) AS avg_rating
FROM User_ u
JOIN Review r ON u.ConsumerUserId = r.UserId
GROUP BY u.ConsumerUserId, u.Name
HAVING AVG(r.Rating) > 4.0
ORDER BY avg_rating DESC;


SELECT ConsumerUserId, Name FROM User_
EXCEPT
SELECT DISTINCT u.ConsumerUserId, u.Name
FROM User_ u
JOIN Order_ o ON u.ConsumerUserId = o.UserId;


SELECT d.DreamId, d.Title
FROM Dream d
JOIN OrderDreamXRef odx ON d.DreamId = odx.DreamId

INTERSECT

SELECT DreamId, Title
FROM Dream;


WITH RankedDreams AS (
    SELECT 
        d.Title AS dream_title,
        dc.Title AS category,
        d.Price,
        ROW_NUMBER() OVER (PARTITION BY dc.DreamCategoryId ORDER BY d.Price DESC) AS rn
    FROM Dream d
    JOIN DreamCategoryDreamXRef dcdx ON d.DreamId = dcdx.DreamId
    JOIN DreamCategory dc ON dcdx.DreamCategoryId = dc.DreamCategoryId
)
SELECT dream_title, category, Price
FROM RankedDreams
WHERE rn <= 3;



SELECT 
    p.Title AS producer,
    SUM(d.Price * odx.Count) AS total_revenue
FROM Producer p
JOIN Dream d ON p.ProducerId = d.ProducerId
JOIN OrderDreamXRef odx ON d.DreamId = odx.DreamId
JOIN Order_ o ON odx.OrderId = o.OrderId
GROUP BY p.ProducerId, p.Title
ORDER BY total_revenue DESC;


-- Пользователи, оставившие отзывы на ВСЕ сны от 'DreamWorks Studio'
SELECT u.Name
FROM User_ u
WHERE NOT EXISTS (
    -- Найти сон от DreamWorks Studio, на который у пользователя НЕТ отзыва
    SELECT d.DreamId
    FROM Dream d
    JOIN Producer p ON d.ProducerId = p.ProducerId
    WHERE p.Title = 'DreamWorks Studio'
    EXCEPT
    SELECT r.DreamId
    FROM Review r
    WHERE r.UserId = u.ConsumerUserId
);


SELECT 'Dream Average Rating' AS metric, AVG(Dream.) AS value
FROM Dream
UNION ALL
SELECT 'Review Average Rating', AVG(Rating)
FROM Review;



SELECT u.Name, u.Email
FROM User_ u
WHERE EXISTS (
    SELECT 1 FROM Order_ o WHERE o.UserId = u.ConsumerUserId
)
AND NOT EXISTS (
    SELECT 1 FROM Review r WHERE r.UserId = u.ConsumerUserId
);


SELECT 'Average Dream Price' AS metric, AVG(Price) AS value
FROM Dream
UNION ALL
SELECT 'Average Review Rating', AVG(Rating)
FROM Review;


