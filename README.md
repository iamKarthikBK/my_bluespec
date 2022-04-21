# Learning BSV

## Lecture 1

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