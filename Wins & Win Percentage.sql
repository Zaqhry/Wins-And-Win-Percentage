



--#### WINS & WIN PERCENTAGE ####



--Wins Per Session,Total Trades,Total Wins & Win Percetange Per Session For FTP

WITH FXCTE AS
(
SELECT Session,
       COUNT(OutcomeFTP) TotalWinsFTP,
       (SELECT COUNT(OutcomeFTP) FROM AUDJPY) TotalTrades,
       ROUND(SUM(TradeID) / (COUNT(OutcomeFTP)),1) WinPercentageFTP
FROM AUDJPY 
WHERE OutcomeFTP = 'Win' 
	GROUP BY Session,
		 OutcomeFTP
)
SELECT Session,   
       (SELECT COUNT(OutcomeFTP) FROM AUDJPY) TotalTrades,
       TotalWinsFTP TotalWinsBySession,
       (SELECT(SUM(TotalWinsFTP)) FROM FXCTE) TotalWinsCombined,
       WinPercentageFTP WinPercentageBySession
FROM FXCTE;

--Wins Per Session,Total Trades,Total Wins & Win Percetange Per Session For TSL

WITH FXCTE AS
(
SELECT Session,
       COUNT(OutcomeTSL) TotalWinsTSL,   
       (SELECT COUNT(OutcomeTSL) FROM AUDJPY) TotalTrades,
       ROUND(SUM(TradeID) / (COUNT(OutcomeTSL)),1) WinPercentageTSL
FROM AUDJPY 
WHERE OutcomeTSL = 'Win' 
	GROUP BY Session,
		 OutcomeTSL
)
SELECT Session,
       (SELECT COUNT(OutcomeTSL) FROM AUDJPY) TotalTrades,   
       TotalWinsTSL TotalWinsBySession,
       (SELECT(SUM(TotalWinsTSL)) FROM FXCTE) TotalWinsCombined,
       WinPercentageTSL WinPercentageBySession
FROM FXCTE;

--FTP Overall Win Percentage For All Sessions Combined

SELECT ROUND(SUM(TradeID) / (COUNT(OutcomeFTP)),1) WinPercentageFTP
FROM AUDJPY 
WHERE OutcomeFTP = 'Win';

--TSL Overall Win Percentage Fro All Sessions Combined

SELECT ROUND(SUM(TradeID) / (COUNT(OutcomeTSL)),1) WinPercentageTSL
FROM AUDJPY 
WHERE OutcomeTSL = 'Win';

--FTP Profit Based On Confluences

SELECT DISTINCT Confluence,
	        COUNT(Confluence) Confluences,
	        SUM(ProfitLossFTP) TotalProfit,
	        ROUND(AVG(ProfitLossFTP),0) AvgProfit,
	        (SELECT SUM(ProfitLossFTP) FROM AUDJPY) OverallProfit
FROM AUDJPY 
WHERE OutcomeFTP = 'Win'
	GROUP BY Confluence
	ORDER BY 2 DESC

--TSL Profit Based On Confluences

SELECT DISTINCT Confluence,
	        COUNT(Confluence) Confluences,
		SUM(ProfitLossTSL) TotalProfit,
		ROUND(AVG(ProfitLossTSL),0) AvgProfit,
		(SELECT ROUND(SUM(ProfitLossTSL),0) FROM AUDJPY) OverallProfit
FROM AUDJPY 
WHERE OutcomeTSL = 'Win'
	GROUP BY Confluence
	ORDER BY 2 DESC
	
	
	
