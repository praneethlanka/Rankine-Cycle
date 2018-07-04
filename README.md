# Rankine-Cycle
Thanks To XSteam. I was able to calculate the various thermodynamic properties at different points seamlessly
The input to the code are taken from 'rankinecycle.xlsx'. In this Excel Sheet there are various tabs in which the input has to be entered rowwise. Note that data entered in a row of a tab corresponds to the data entered in the same row number of another different tab. Care has to be taken while entering the data.

Data entry must be done very carefully. Data entered in Row 1 of each Tab Corresponds to one cycle, similarly Row 2 and so on.

### The data in the excel sheet has to be entered as shown in the images below:
1. In 'Rankine Pressures'
![screenshot 56](https://user-images.githubusercontent.com/35808849/42287947-43a90474-7fd6-11e8-8215-65f6fbdc053d.png)
In the first column the condensor pressure has to be entered and in the secon column the boiler pressure has to be entered

2. In 'Boiler Temperatures'
![screenshot 65](https://user-images.githubusercontent.com/35808849/42289390-c77e1c5c-7fdc-11e8-95fe-74a5073389f9.png)
Note that in the first column the temperature at the boiler input has to be entered and in the second column the temperature at the boiler output has to be entered

3. In 'Reheat'
![screenshot 61](https://user-images.githubusercontent.com/35808849/42288433-4e2c3c66-7fd8-11e8-9934-213ecbc7d141.png)
Here the number of reheat cycles has to be entered in each row. Observe that in few rows 0 has been entered, this indicated that there are no reheat cycles in that particular Rankine Cycle, i.e, Steam directly enters into the condensor form the output of boiler.

4. In 'Reheat Pressure Drops'
![screenshot 62](https://user-images.githubusercontent.com/35808849/42288603-0b10c540-7fd9-11e8-9a98-48abc5b6326d.png)
Corresponding to the number entered in each row of the 'Reheat' Tab, number of columns in the different rows of the 'Rankine Pressure Drops' Tab has to be entered as shown in the above image.

5. In 'Reheat Temperatures'
![screenshot 63](https://user-images.githubusercontent.com/35808849/42288752-c9aa2c9e-7fd9-11e8-9abb-dfc0b6daee33.png)
Similar to the 'Reheat Pressure Drops' the Temperature to which Steam has to be heated in each of these cycles has to be enterd as shown in the above image.

6. In 'OUTPUT'
![screenshot 66](https://user-images.githubusercontent.com/35808849/42289411-ec0cfa48-7fdc-11e8-8e27-35371e8b1b79.png)
In the Column A: Total Turbine Work in that corresponding cycle is given as output in all the rows.

In the Column C: Total Pump Work in that corresponding cycle is shown

In the Column E: Total Heat that is added in the cycle is shown

In the Column G: The Efficiency of the cycle is given as output.

At the end the change in efficiency is plotted with the change in boiler and condensor pressures. So, I suggest the user to keep either of the pressures constant while changing the others to know  its effect on the efficiency of the cycle.

There are further addition that need to be done to this like adding the Regenerator cycle
