-- EEEEEEEEEEEEEEEEEEEEEE		XXXXXXX       XXXXXXX		               AAA               	MMMMMMMM               MMMMMMMM
-- E::::::::::::::::::::E		X:::::X       X:::::X		              A:::A              	M:::::::M             M:::::::M
-- E::::::::::::::::::::E		X:::::X       X:::::X		             A:::::A             	M::::::::M           M::::::::M
-- EE::::::EEEEEEEEE::::E		X::::::X     X::::::X		            A:::::::A            	M:::::::::M         M:::::::::M
--   E:::::E       EEEEEE		XXX:::::X   X:::::XXX		           A:::::::::A           	M::::::::::M       M::::::::::M
--   E:::::E             		   X:::::X X:::::X   		          A:::::A:::::A          	M:::::::::::M     M:::::::::::M
--   E::::::EEEEEEEEEE   		    X:::::X:::::X    		         A:::::A A:::::A         	M:::::::M::::M   M::::M:::::::M
--   E:::::::::::::::E   		     X:::::::::X     		        A:::::A   A:::::A        	M::::::M M::::M M::::M M::::::M
--   E:::::::::::::::E   		     X:::::::::X     		       A:::::A     A:::::A       	M::::::M  M::::M::::M  M::::::M
--   E::::::EEEEEEEEEE   		    X:::::X:::::X    		      A:::::AAAAAAAAA:::::A      	M::::::M   M:::::::M   M::::::M
--   E:::::E             		   X:::::X X:::::X   		     A:::::::::::::::::::::A     	M::::::M    M:::::M    M::::::M
--   E:::::E       EEEEEE		XXX:::::X   X:::::XXX		    A:::::AAAAAAAAAAAAA:::::A    	M::::::M     MMMMM     M::::::M
-- EE::::::EEEEEEEE:::::E		X::::::X     X::::::X		   A:::::A             A:::::A   	M::::::M               M::::::M
-- E::::::::::::::::::::E		X:::::X       X:::::X		  A:::::A               A:::::A  	M::::::M               M::::::M
-- E::::::::::::::::::::E		X:::::X       X:::::X		 A:::::A                 A:::::A 	M::::::M               M::::::M
-- EEEEEEEEEEEEEEEEEEEEEE		XXXXXXX       XXXXXXX		AAAAAAA                   AAAAAAA	MMMMMMMM               MMMMMMMM

/*
	[LT] Žemiau rasite pateiktas užklausas ataskaitoms. Kiekviena ataskaita yra finalinės ataskaitos 
		žingsnis, todėl neskubėkite pereiti prie sekančio uždavinio, kol neužbaigėte prieš tai buvusio,
        nes turint neteisingą duomenų šaltinį gali kisti tolimesni rezultatai. Kiekvieno uždavinio 
        rezultatai turi būti išsaugoti vis naujoje laikinoje lentelėje pagal pavadinimo
        šabloną 'temp_TaskX'
		Vertinimas - Viso 100 taškų
			* Teisingas sprendimas - 15 taškų
            * Kodo kultūra (formatavimas) - 5 taškai       
*/
-- #####################################################################################################
-- #####################################################################################################
DROP TABLE IF EXISTS temp_Task1;																	  ##
DROP TABLE IF EXISTS temp_Task2;	-- [EN] CLEAR ENVIRONMENT, DO NOT CHANGE ANYTHING				  ##
DROP TABLE IF EXISTS temp_Task3;																	  ##
DROP TABLE IF EXISTS temp_Task4;	-- [LT] APLINKOS PARUOŠIMAS DARBUI, NIEKO KEISTI NEREIKIA		  ##
DROP TABLE IF EXISTS temp_Task5;																	  ##
-- #####################################################################################################
-- #####################################################################################################
/*
THINGS YOU WILL NEED
	SELECT: Used to specify the columns you want to retrieve from a database table.
	FROM: Specifies the table or tables from which to retrieve the data.
	JOIN: Combines rows from two or more tables based on a related column between them.
	WHERE: Filters the rows in a table based on specified conditions.
	GROUP BY: Groups the rows in a table based on specified columns, often used with aggregate functions.
	ORDER BY: Sorts the result set in ascending or descending order based on specified columns.
	CASE: Evaluates a set of conditions and returns a result based on the first condition that is met.
	SUBQUERY: A query nested within another query, used to retrieve data for a specific condition.
	CREATE TEMPORARY TABLE: Creates a temporary table that exists only for the duration of a session or transaction.
    DISTINCT: Helps to indentify unique values in the list.

FUNCTIONS:
	SUM(): Calculates the sum of values in a specified column.
    COUNT(): Counts the number of rows or non-null values in a specified column.
	AVG(): Calculates the average of values in a specified column.
	MAX(): Retrieves the maximum value from a specified column.
	MIN(): Retrieves the minimum value from a specified column.
	CONCAT(): Concatenates two or more strings together.
	ROUND(): Rounds a numeric value to a specified number of decimal places.
    DATEDIFF(): Shows difference is days between two dates.
*/
-- #####################################################################################################
-- #####################################################################################################
																							-- TASK 1 
-- [LT] Bandome suprasti kaip sekasi mūsų dabartinėms parduotuvėms. Mums reikia ataskaitos kurioje
	-- matytųsi atidarytų parduotuvių numeris, pardavimų skaičius per visą periodą, uždirbta suma, vidutinis 
    -- vienkartinis mokėjimas ir kiek skirtingų klientų buvo apsiprekinę parduotuvėje. Taip pat reiktų 
    -- matyti kiek laiko jau dirba parduotuvė. Sąraše nėra būtina matyti daugiau nei 5 daugiausiai 
    -- uždirbusių ir daugiausiai pardavimų atlikusių parduotuvių.
    
-- Tables/lentelės (not in order/ne iš eilės)
	-- store
    -- payment
    -- staff
    -- address

-- SOLUTION
CREATE TEMPORARY TABLE temp_Task1 AS
SELECT st.store_id AS 'Store'
	, COUNT(*) AS 'Number Of Sales'
    , ROUND(SUM(amount)) AS 'Total Profit'
    , ROUND(AVG(amount),2) AS 'Average payment'
    , COUNT(DISTINCT p.customer_id) AS 'Unique customers'
    , DATEDIFF(MAX(p.payment_date), MIN(p.payment_date)) AS 'Number Of Days In Business'
FROM payment AS p
JOIN staff AS s ON s.staff_id = p.staff_id
JOIN store AS st ON st.store_id = s.store_id
-- JOIN address AS a ON a.address_id = st.address_id
WHERE s.active = 1
GROUP BY st.store_id
ORDER BY `Total Profit` DESC
	, `Number Of Sales` DESC
LIMIT 5;

-- REPORT
SELECT * 			-- [DO NOT CHANGE]
FROM temp_Task1;	-- [NEKEISTI]

-- EXPECTED RESULSTS - 2 rows
-- || Store 	|| Number Of Sales 	|| Total Profit || Average payment 	|| Unique customers || Number Of Days In Business 	|| 
-- || 2 		|| 7990 			|| 33924 		|| 4.25 			|| 599 				|| 266							|| 
-- || 1 		|| 8054 			|| 33483 		|| 4.16  			|| 599				|| 266							||
-- #####################################################################################################
-- #####################################################################################################
																							-- TASK 2 
-- [LT] Gerai, bet kad tiksliau įsivertintumėme poreikį reikia iškart išskaičiuoti vidutinį pelną per
	-- klientą ir vidutinį pelną per dieną (vartinant visą darbo periodą). Ai ir tuo pačiu paskaičiuokite 
    -- kiek skirtingų filmų turime kiekvienoje parduotuvėje. Ten kur kalbama apie pinigus, nurodykite sumą
    -- su dolerio ženklu, o rezultatus pateikite nuo didžiausio pelno per klientą.
    
-- Tables/lentelės (not in order/ne iš eilės)
    -- temp_Task1
    -- inventory
    
-- SOLUTION
CREATE TEMPORARY TABLE temp_Task2 AS
SELECT t_1.Store
	, CONCAT('$ ', t_1.`Total Profit`) AS 'Total Profit'
    , t_1.`Unique Customers`
    , CONCAT('$ ', ROUND(t_1.`Total Profit` / t_1.`Unique Customers`,2)) AS 'Average Profit Per Customer'
    , t_1.`Number Of Days In Business`
    , CONCAT('$ ', ROUND(t_1.`Total Profit` / t_1.`Number Of Days In Business`,2)) AS 'Average Profit Per Day'
	, (
		SELECT COUNT(DISTINCT i.film_id)
		FROM inventory AS i
		WHERE i.store_id = t_1.Store
	) AS 'Number Of Unique Movies'
FROM temp_Task1 AS t_1
ORDER BY `Average Profit Per Customer` DESC;

-- REPORT
SELECT *			-- [DO NOT CHANGE]
FROM temp_Task2;	-- [NEKEISTI]

-- EXPECTED RESULSTS - 2 rows
-- || Store || Total Profit || Unique Customers ||	Average Profit Per Customer ||	Number Of Days In Business	||	Average Profit Per Day	|| 	Number Of Unique Movies ||
-- || 2		|| $ 33924		|| 599 				||	$ 56.63						||	266							||	$ 127.53				||	762						||
-- || 1 	|| $ 33483 		|| 599 				||	$ 55.90						||	266							||	$ 125.88				||	759						||
-- #####################################################################################################
-- #####################################################################################################
																							-- TASK 3 
-- [LT] Labai geros ataskaitos - taip ir toliau! Nusprendėme atidaryti naują parduotuvę, dabar 
	-- planuojame užsakyti inventorių. Norime išvengti filmų kurie jau dabar neatneša pelno kitose 
    -- parduotuvėse. Prašau parodykite 150 filmų kurie uždirbo mažiausiai. Vertinkite tik tuos filmus 
    -- kurie nėra "Horror" arba "Sports" kategorijoje ir yra išleisti 2006 metais arba jie ilgesni už
    -- 135 min. Mums reikia filmo ID, pavadinimo + žanras, bendro pelno. Visgi, kaikurie filmai natūraliai
    -- uždirba mažiau, tad reiktų patyrinėti ar žinome kodėl filmas galėjo būti nišinis.
		-- Jeigu filmo žanras siaubo - įrašykite [Horror movies always has lower rent.]
		-- Jeigu filmo žanras sportas ir reitingas R - įrašykite [Sport with an R rating is a bad decision.]
        -- Jeigu filmas ilgesnis nei 170 min - įrašykite [Longer movies tend to be rented less.]
        -- Jeigu priežastis nežinoma - įrašykite [Unknown]
	-- Atsakymus surūšiuokite ta pačia eilės tvarka kaip pateikta apraše pagal numanomą priežastį ir 
    -- didžiausią pelną.
    
-- Tables/lentelės (not in order/ne iš eilės)
	-- film
	-- payment
	-- category
    -- rental
    -- inventory
    -- film_category
    
-- SOLUTION
CREATE TEMPORARY TABLE temp_Task3 AS
SELECT f.film_id
	, CONCAT(f.Title, ' ( ',c.Name, ' )') AS 'Movie'
	, SUM(amount) AS 'Total Profit'
    , CASE 
		WHEN c.Name = 'Horror'
			THEN 'Horror movies always has lower rent.'
		WHEN c.Name = 'Sports' AND rating = 'R'
			THEN 'Sport with an R rating is a bad decision.'
		WHEN length > 170
			THEN 'Longer movies tend to be rented less.'
		ELSE 'Unknown'
    END AS 'Possible Reason'
FROM payment AS p
JOIN rental AS r ON p.rental_id = r.rental_id
JOIN inventory AS i ON i.inventory_id = r.inventory_id
JOIN film AS f ON f.film_id = i.film_id
JOIN film_category AS fc ON fc.film_id = f.film_id
JOIN category AS c ON c.category_id = fc.category_id
WHERE c.name NOT IN ('Horror','Sports')
AND release_year = 2006
OR length > 135
GROUP BY f.film_id
	, c.category_id
ORDER BY CASE 
	WHEN `Possible Reason` = 'Horror movies always has lower rent.'
		THEN 1
	WHEN `Possible Reason` = 'Sport with an R rating is a bad decision.'
		THEN 2
	WHEN `Possible Reason` = 'Longer movies tend to be rented less.'
		THEN 3
	ELSE 4
    END
    , `Total Profit` DESC
LIMIT 150;

-- REPORT
SELECT *			-- [DO NOT CHANGE]
FROM temp_Task3;	-- [NEKEISTI]

-- EXPECTED RESULSTS - 150 rows
-- || film_id 	|| Movie 									|| Total Profit 	|| Possible Reason 					||
-- || 35		|| ARACHNOPHOBIA ROLLERCOASTER ( Horror )	|| 114.76	|| Horror movies always has lower rent.		||
-- || 665		|| PATTON INTERVIEW ( Horror )				|| 102.77	|| Horror movies always has lower rent.		||
-- || 749 		|| RULES HUMAN ( Horror )					|| 101.84	|| Horror movies always has lower rent.		||
-- || ...		|| ...										|| ... 		|| ...										||
-- #####################################################################################################
-- #####################################################################################################
																							-- TASK 4  
-- [LT] Puiku, žinome kurie filmai yra nepelningi ir jų reikia vengti. Todėl dabar reikia sužinoti 
	-- kokius filmus užsakyti naujai parduotuvei! Gaukite 25 pelingiausių filmų sąrašą, jų 
    -- id + pavadinimą, kategoriją ir bendrą pelną. Užtikrinkite, kad į šį sąrašą nepakliūtų nė vienas
    -- filmas iš praeito sąrašo su priežastimi 'Unknown'!!!
        
-- Tables/lentelės (not in order/ne iš eilės)
	-- film
	-- payment
	-- category
    -- rental
    -- temp_Task3
    -- inventory
    -- film_category
                                                                                            
-- SOLUTION
CREATE TEMPORARY TABLE temp_Task4 AS
SELECT CONCAT('(', f.film_id, ') ', f.title) AS 'Movie'
    , c.Name AS 'Category Name'
    , SUM(amount) AS 'Total Profit'
FROM film AS f
JOIN film_category AS fc ON fc.film_id = f.film_id
JOIN category AS c ON c.category_id = fc.category_id
JOIN inventory AS i ON i.film_id = f.film_id
JOIN rental AS r ON r.inventory_id = i.inventory_id
JOIN payment AS p ON p.rental_id = r.rental_id
WHERE f.film_id NOT IN ( 
	SELECT t_f.film_id
	FROM temp_Task3 AS t_f
    WHERE `Possible Reason` = 'Unknown'
    )
GROUP BY f.film_id
	, c.category_id
ORDER BY `Total Profit` DESC
LIMIT 25;

-- REPORT
SELECT *			-- [DO NOT CHANGE]
FROM temp_Task4;	-- [NEKEISTI]

-- EXPECTED RESULSTS - 25 rows
-- ||	Movie					|| 	Category Name	||	Total Profit 	||
-- || 	(973) WIFE TURN			|| 	Documentary 	||	223.69 			||
-- || 	(897) TORQUE BOUND		||	Drama 			||	198.72 			||
-- || 	(460) INNOCENT USUAL	|| 	Foreign 		||	191.74 			||
-- || ...						|| ... 				||	... 			||
-- #####################################################################################################
-- #####################################################################################################
																							-- TASK 5
-- [LT] Puiku! Žinome kokių filmų norime užsipirkti. Dabar liko sukurti reklamą. Kiekvienai kategorijai
	-- sukursime atskirą reklamą reklamuojančią populiariausią filmą. Išrinkite kiekvienos kategorijos
    -- daugiausiai uždirbusį filmą!
    
-- Tables/lentelės (not in order/ne iš eilės)
	-- temp_Task4
    -- Maybe another temp table/gal papildoma temp lentelė [Error Code: 1137. Can't reopen table: 't4']
		-- [EN] You could not use a single temp table twice in the same query.
		-- [LT] Vienoje užklausoje 2 kartus negalima naudoti tos pačios temp lentelės.
    
-- SOLUTION
CREATE TEMPORARY TABLE temp_BiggestProfitByCategory
SELECT t4.`Category Name`
	, MAX(t4.`Total Profit`) AS 'Biggest Profit'
FROM temp_Task4 AS t4
GROUP BY t4.`Category Name`;

CREATE TEMPORARY TABLE temp_Task5 AS
SELECT t4.`Category Name`
	, t4.`Movie`
    , CONCAT('$ ',t4.`Total Profit`) AS 'Total Profit'
FROM temp_Task4 AS t4
JOIN temp_BiggestProfitByCategory AS tBPC ON tBPC.`Category Name` = t4.`Category Name` AND tBPC.`Biggest Profit` = t4.`Total Profit`
ORDER BY t4.`Total Profit` DESC;
DROP TABLE temp_BiggestProfitByCategory;

-- REPORT
SELECT *			-- [DO NOT CHANGE]
FROM temp_Task5;	-- [NEKEISTI]
-- EXPECTED RESULSTS - 13 rows
-- || Category Name	|| Movie					||	Total Profit 	|| 
-- || Documentary	|| (973) WIFE TURN 			||	$ 223.69		|| 
-- || Drama			|| (897) TORQUE BOUND		||	$ 198.72		|| 
-- || Foreign		|| (460) INNOCENT USUAL 	||	$ 191.74		|| 
-- || ...			|| ... 						||	...				||
-- #########################################################################################################################################################################################################
-- #########################################################################################################################################################################################################
-- #########################################################################################################################################################################################################
-- #########################################################################################################################################################################################################
																																										
--         GGGGGGGGGGGGG	     OOOOOOOOO     		     OOOOOOOOO     		DDDDDDDDDDDDD             	LLLLLLLLLLL            		UUUUUUUU     UUUUUUUU	       CCCCCCCCCCCCC	KKKKKKKKK    KKKKKKK
--      GGG::::::::::::G	   OO:::::::::OO   		   OO:::::::::OO   		D::::::::::::DDD          	L:::::::::L            		U::::::U     U::::::U	    CCC::::::::::::C	K:::::::K    K:::::K
--    GG:::::::::::::::G	 OO:::::::::::::OO 		 OO:::::::::::::OO 		D:::::::::::::::DD        	L:::::::::L            		U::::::U     U::::::U	  CC:::::::::::::::C	K:::::::K    K:::::K
--   G:::::GGGGGGGG::::G	O:::::::OOO:::::::O		O:::::::OOO:::::::O		DDD:::::DDDDD:::::D       	LL:::::::LL            		UU:::::U     U:::::UU	 C:::::CCCCCCCC::::C	K:::::::K   K::::::K
--  G:::::G       GGGGGG	O::::::O   O::::::O		O::::::O   O::::::O		  D:::::D    D:::::D      	  L:::::L              		 U:::::U     U:::::U 	C:::::C       CCCCCC	KK::::::K  K:::::KKK
-- G:::::G              	O:::::O     O:::::O		O:::::O     O:::::O		  D:::::D     D:::::D     	  L:::::L              		 U:::::D     D:::::UC	:::::C              	  K:::::K K:::::K   
-- G:::::G              	O:::::O     O:::::O		O:::::O     O:::::O		  D:::::D     D:::::D     	  L:::::L              		 U:::::D     D:::::UC	:::::C              	  K::::::K:::::K    
-- G:::::G    GGGGGGGGGG	O:::::O     O:::::O		O:::::O     O:::::O		  D:::::D     D:::::D     	  L:::::L              		 U:::::D     D:::::UC	:::::C              	  K:::::::::::K     
-- G:::::G    G::::::::G	O:::::O     O:::::O		O:::::O     O:::::O		  D:::::D     D:::::D     	  L:::::L              		 U:::::D     D:::::UC	:::::C              	  K:::::::::::K     
-- G:::::G    GGGGG::::G	O:::::O     O:::::O		O:::::O     O:::::O		  D:::::D     D:::::D     	  L:::::L              		 U:::::D     D:::::UC	:::::C              	  K::::::K:::::K    
-- G:::::G        G::::G	O:::::O     O:::::O		O:::::O     O:::::O		  D:::::D     D:::::D     	  L:::::L              		 U:::::D     D:::::UC	:::::C              	  K:::::K K:::::K   
--  G:::::G       G::::G	O::::::O   O::::::O		O::::::O   O::::::O		  D:::::D    D:::::D      	  L:::::L         LLLLLL	 U::::::U   U::::::U 	C:::::C       CCCCCC	KK::::::K  K:::::KKK
--   G:::::GGGGGGGG::::G	O:::::::OOO:::::::O		O:::::::OOO:::::::O		DDD:::::DDDDD:::::D       	LL:::::::LLLLLLLLL:::::L	 U:::::::UUU:::::::U 	 C:::::CCCCCCCC::::C	K:::::::K   K::::::K
--    GG:::::::::::::::G	 OO:::::::::::::OO 		 OO:::::::::::::OO 		D:::::::::::::::DD        	L::::::::::::::::::::::L 	 UU:::::::::::::UU  	  CC:::::::::::::::C	K:::::::K    K:::::K
--      GGG::::::GGG:::G	   OO:::::::::OO   		   OO:::::::::OO   		D::::::::::::DDD          	L::::::::::::::::::::::L   	 	UU:::::::::UU    	    CCC::::::::::::C	K:::::::K    K:::::K
--         GGGGGG   GGGG	     OOOOOOOOO     		     OOOOOOOOO     		DDDDDDDDDDDDD             	LLLLLLLLLLLLLLLLLLLLLLLL     	   UUUUUUUUU      	       CCCCCCCCCCCCC	KKKKKKKKK    KKKKKKK