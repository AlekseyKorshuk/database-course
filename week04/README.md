# Lab 4

# **Exercise 1**

### Find the names of suppliers who supply some red part.

			$π_{sname}(π_{sid}((π_{pid}σ_{color}=red(Parts)) ⋈ Catalog)⋈ Suppliers)$

				
			
		
	
	

### Find the sids of suppliers who supply some red or green part.

$π_{sid}(π_{pid}(σ_{color}=red∨ color=green (Parts))⋈ Catalog)$

### Find the sids of suppliers who supply some red part or are at 221 Packer Street.

$π_{sid}((π_{pid}σ_{color}= red (Parts)) 
	⋈					Catalog)
					∪ 

	
		
		
	
	
		
			
				
		(			π_{sid}σ_{address}=221PackerStreet (Suppliers))$

				
			
		
	

### Find the sids of suppliers who supply some red part and some green part.

	
		
		
	
	
		
			
				
					$π_{sid}(σ_{colour}=red (Part) ⋈ Catalog) ∩ π_{sid}(σ_{colour}=green (Part) ⋈ Catalog)$

				
			
		
	

### Find the sids of suppliers who supply every part.

$(π_{sid,pid} Catalog)/(π_{pid} Parts)$

### Find the sids of suppliers who supply every red part.

$(π_{sid,pid} Catalog)/(π_{pid} σ_{color=red} Parts)$

### Find the sids of suppliers who supply every red or green part.

$(π_{sid,pid} Catalog)/(π_{pid} σ_{color=red ∨ color=green} Parts)$

### Find the sids of suppliers who supply every red part or supply every green part.

$((π_{sid,pid} Catalog)/(π_{pid }σ_{color}=red (Parts))) U ((π_{sid,pid} Catalog)/(π_{pid }σ_{color}=green (Parts)))$
				
			
		

### Find pairs of sids such that the supplier with the first sid charges more for some part than the supplier with the second sid.

$π_{Catalog_1.sid,Catalog_2.sid}(σ_{Catalog_1.pid=Catalog_2.pid ∧ Catalog_1.sid != Catalog_2.sid ∧ Catalog_1.cost > Catalog_2.cost }(Catalog_1 × Catalog_2))$

### Find the pids of parts supplied by at least two different suppliers.

$π_{Catalog_1.pid} σ_{Catalog_1.pid=Catalog_2.pid ∧ Catalog_1.sid != Catalog_2.sid }(Catalog_1 × Catalog_2)$

# **Exercise 2**

![Screenshot 2022-03-25 at 17.05.37.png](Lab%204%20643a2/Screenshot_2022-03-25_at_17.05.37.png)

Find the names of Suppliers who supplied some red part for less than 100$.

![Screenshot 2022-03-25 at 17.05.46.png](Lab%204%20643a2/Screenshot_2022-03-25_at_17.05.46.png)

List the names of suppliers so that there is a supplier with that name who can supply a red part for less than 100$ and another who can offer a green part for less than 100$.

![Screenshot 2022-03-25 at 17.06.05.png](Lab%204%20643a2/Screenshot_2022-03-25_at_17.06.05.png)

Return just the sids of suppliers who supply some red part for less than $100 and some green part for less than $100, as listed in the table Supplier.

![Screenshot 2022-03-25 at 17.06.15.png](Lab%204%20643a2/Screenshot_2022-03-25_at_17.06.15.png)

Show the names of suppliers that can provide some red parts for under $100 and some green parts for under $100.