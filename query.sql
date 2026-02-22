-- ТОП-3 продуктов (по общему числу прохождений)
WITH TopProducts AS (
    SELECT 
        game_product_id,
        COUNT(*) AS total_sessions
    FROM GameSession
    WHERE session_date BETWEEN '2025-06-01' AND '2025-08-31'
    GROUP BY game_product_id
    ORDER BY total_sessions DESC
    LIMIT 3
)
SELECT 
    gp.name AS game_product_name,
    qt.name AS theme,
    ag.name AS age_group,
    bp.type AS parent_product_type,
    COUNT(*) AS session_count
FROM GameSession gs
JOIN TopProducts tp ON gs.game_product_id = tp.game_product_id
JOIN GameProduct gp ON gs.game_product_id = gp.game_product_id
JOIN QuestTheme qt ON gp.theme_id = qt.theme_id
JOIN Child c ON gs.child_id = c.child_id
JOIN AgeGroup ag ON c.age_group_id = ag.age_group_id
JOIN Parent p ON c.parent_id = p.parent_id
LEFT JOIN ParentBankProduct pbp ON p.parent_id = pbp.parent_id
LEFT JOIN BankProduct bp ON pbp.bank_product_id = bp.bank_product_id
WHERE gs.session_date BETWEEN '2025-06-01' AND '2025-08-31'
GROUP BY gp.name, qt.name, ag.name, bp.type
ORDER BY session_count DESC;