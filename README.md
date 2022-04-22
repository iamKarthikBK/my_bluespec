# Learning BSV

## Lecture 1, 2, 3

- 17:15 -> Why does the start method have 'Action' but not the result method?
- 51:13 -> BSV preserves module hierarchy very well, by treating the smallest of elements (including registers) as modules.
- 51:13 -> SystemC and other high level HDL don't allow us to make use of all kinds of abstraction and parameterization when we are trying to write synthesizable code. Bluespec allows us to do everything, while still retaiing the 'synthesizability'.
- 2:40:31 -> Where do we use Maybe#(t) ? 
-- it contains two things first the data and second field to tell is the data valid.. here, hit index is a 'maybe' type variable.

```
 /* hit entry is assigned the value of the tlb entry that is a "hit" out of all the tlbs of different page size
			* reverse function is used in selecting the hit as for multiple hits in different tlb preference is
			* given to superpage entry*/
			let hit_entry = find(fn_select, reverse(v_resp));
			/* hit index capture the index of the "hit" entry telling which page the hit corresponds to*/ 
			let hit_index = findIndex(fn_select, reverse(v_resp));
			/* napot_index contains the valid hit_index of the hit entry else if miss then its don't care*/
			let napot_index = fromMaybe(?, hit_index);
    (~ Via Shubham)
```

## Lecture 4, 5, 6

- 13:13 -> The BSV shorthand, for some reason it seems like it should be the other way round ??? Why would you initialize an interface with the binding for the module that's using it? Rather, we should mention all the interfaces a module with communicate with, in the port-list. in fact, we already do that. I don't understand the concept of binding interfaces with modules.

- 40:13 -> at any given point of time, if we just take a look at all the rules that are available for firing, and see which ones have their condition as true, we fire a single rule, based on the priority, right? what if i haven't told the priority explicitly. assume there's 5 out of 10 rules at all posedge available for firing, with their conditions true. can we fire \emph{multiple} rules? if no, then how does bsv choose which one to fire?

-- 1:09:22 - multiple rules are executed concurrently (in the same clock cycle). details in lecture 6.