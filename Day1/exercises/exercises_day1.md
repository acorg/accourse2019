# Exercises day 1

## Understanding map making
Take the following HI table:


### HI table
|      |Sr-LE |Sr-BN |Sr-JO |Sr-BE |Sr-HK ||:-----|:-----|:-----|:-----|:-----|:-----||Ag-LE |640   |40    |20    |<10   |<10   ||Ag-BN |320   |1280  |20    |<10   |40    ||Ag-JO |20    |10    |1280  |20    |10    ||Ag-BE |10    |10    |160   |320   |80    ||Ag-HK |10    |10    |10    |160   |320   |

<br/>

1. Convert the values to log titers
- Convert the log titers to table distances assuming a minimum column basis of "none", "320" and "1280".
- Now, given the following table of map distances, fill in the table of stress measurements

<br/>

|      |Sr-LE |Sr-BN |Sr-JO |Sr-BE |Sr-HK ||:-----|:-----|:-----|:-----|:-----|:-----||Ag-LE |      |      |      |      |      ||Ag-BN |      |      |      |      |      ||Ag-JO |      |      |      |      |      ||Ag-BE |      |      |      |      |      ||Ag-HK |      |      |      |      |      |

<br/>

## Remaking the map of H3N2 evolution
Imagine you have been sent, or generated yourself, the HI data in the excel sheets found in the folder `h3map_titrations` and you would like to use that information to make an antigenic map to understand antigenic differences between viruses.

1. Piece together the data (either by hand or programatically if you can already) into a single titer table that can be read by the Racmacs GUI.

2. Open the GUI and load in the titer table, performing 100 optimization runs with the minimum column basis set to none.

    - Does it look like the optimizer has found a stable solution for the antigen and serum positions? How can you check?

    - Perform some diagnostics, checking for hemisphering or trapped points.

    - Look for trapped points in one of the optimizations created and move them.

3. Color your plot by loading in the file `h3map2004.ace` as the reference file.

4. Save the map as a .ace file

    - Save the coordinates of points in the map

    - Alternatively save only the coordinates for antigens or only the coordinates for sera

    - Save the HI table from the map

5. Compare the positions of points in your map to the positions of points in the map published in 2004 in the file `h3map2004.ace` by running a procrustes.

6. Now clear all the optimizations and rerun the optimizations, setting a minimum column basis of 1280.

7. Take the lowest stress optimization from this map and compare it with procrustes to the map file you saved when using a minimum column basis of "none". Did changing the minimum column basis make much difference? What would it mean if it did?

8. Calculate stress blobs for your map with a stress limit of 1. Why would you want to do this and what do these blobs show? Why should they not be interpreted as confidence intervals?

9. Download an image of your map.

<br/>

## Testing your knowledge

By the end of the day, make sure you are happy with the answers to the following questions:

- How are antiserum - antigen titers converted to expected antigenic distances between antigens and antisera?

- What role does the column basis have in the conversion of titers to expected distances? What does the default setting of "none" mean? Why might you want to set a different minimum column basis?

- What does the stress of point mean and how is it calculated? What are the reasons that certain points may be more stressed?

- Why do you end up with so many different optimizations after performing an optimization run?

- How can you check that the optimizer has found a stable solution for optimal point positions in your map?

- How can you test if your map is a good representation of the assay data? How can you work out if your data is best represented in 2 or 3 or more dimensions?