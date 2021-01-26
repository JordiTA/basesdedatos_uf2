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
END//
DELIMITER;

CALL doiterate(1);

/*-------------------------------------------------------------*/

DELIMITER$$
CREATE PROCEDURE relate_character_item (IN in_id_chararacter INT UNSIGNED, IN in_id_item INT UNSIGNED)
BEGIN
    
    INSERT INTO characters_items (id_character,id_item)
        VALUES (in_id_character,in_id_item);
    
END$$

DELIMITER;

CALL relate_character_item(2,3);

/*-------------------------------------------------------------*/

DELIMITER$$
CREATE FUNCTION insert_item(in_item VARCHAR(24),in_cost INT,in_consumable BOOLEAN,in_tradeable BOOLEAN,in_weight FLOAT,in_id_item_type INT UNSIGNED ) RETURNS INT UNSIGNED
BEGIN
    INSERT INTO items(item,cost,consumabke,tradeable,weight,id_item_type)
        VALUES (in_item,in_cost,in_consumabke,in_tradeable,in_weight,in_id_item_type);

    RETURN LAST_INSERT_ID();

END$$
DELIMITER;

/*-------------------------------------------------------------*/

DELIMITER $$
CREATE FUNCTION id_item_by_name(in_item VARCHAR(24)) RETURNS INT UNSIGNED
BEGIN
    SET @id := 0;
    
    SELECT id_item INTO @id FROM items WHERE items LIKE in_item LIMIT 1;
    
    RETURN @id;
END $$
DELIMITER;

SELECT id_item_by_name('%zana');