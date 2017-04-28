Data from a 2006 research was analyzed to find whether neighbors or any other factors affect the decision of an individual to vote or not to vote. Used R for statistical analysis and built logistic regression models and decision trees to observe how the probabilities of the different target groups were changing. Also explored whether gender had any major role to play in the decision.

The researchers grouped about 344,000 voters into different groups randomly - about 191,000 voters were a "control" group, and the rest were categorized into one of four "treatment" groups. These five groups correspond to five binary variables in the dataset.

	"Civic Duty" (variable civicduty) group members were sent a letter that simply said "DO YOUR CIVIC DUTY - VOTE!"
	
	"Hawthorne Effect" (variable hawthorne) group members were sent a letter that had the "Civic Duty" message plus the additional message "YOU ARE BEING STUDIED" and they were informed that their voting behavior would be examined by means of public records.
	
	"Self" (variable self) group members received the "Civic Duty" message as well as the recent voting record of everyone in that household and a message stating that another message would be sent after the election with updated records.
	
	"Neighbors" (variable neighbors) group members were given the same message as that for the "Self" group, except the message not only had the household voting records but also that of neighbors - maximizing social pressure.
	
    "Control" (variable control) group members were not sent anything, and represented the typical voting situation.

Additional variables include sex (0 for male, 1 for female), yob (year of birth), and the dependent variable voting (1 if they voted, 0 otherwise).
