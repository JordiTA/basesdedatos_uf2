DELIMITER;

DROP PROCEDURE IF EXISTS nombreDelProcedimiento


DELIMITER //

CREATE PROCEDURE GetItemNameById (IN iditem INT UNSIGNED, OUT name VARCHAR(24))
BEGIN
    SELECT item INTO name FROM items WHERE id_item=iditem;
END//

DELIMITER;


DELIMITER //

CREATE PROCEDURE GetItemById (IN iditem INT UNSIGNED)
BEGIN
    DELETE FROM items WHERE id_item=iditem;
END//

DELIMITER;





DELIMITER //
CREATE FUNCTION suma (a INT UNSIGNED, B INT UNSIGNED) RETURNS INT UNSIGNED
BEGIN
    RETURN a+b;
END //
DELIMITER;


DELIMITER //

CREATE PROCEDURE getItemByCharacterId (IN idcharacter INT UNSIGNED,
                                        OUT iditem INT UNSIGNED,
                                        OUT item VARCHAR(24),
                                        OUT cost INT)
BEGIN
    SELECT *
    FROM characters
    LEFT JOIN character_items
        ON characters.id_character=characters_items.id_character
    LEFT JOIN items
        ON character_items.id_item=items_id_item
    WHERE characters.id_character=idcharacter
    LIMIT 1;
END //
DELIMITER;


DELIMITER //
CREATE PROCEDURE doiterate(p1 INT)
BEGIN
    label1: LOOP
        SET p1 = p1 + 1;
        if p1 < 10 THEN
            ITERATE label1;
        END IF;
        LEAVE label1;
    END LOOP label1;
    SET @x = p1;
END$$
DELIMITER;

CALL doiterate(1);