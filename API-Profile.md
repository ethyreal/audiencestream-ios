# Profile API

## Profile

**Nested Classes**

* [Audience](#audience)
* [Attribute](#attribute)
* [Badge](#badge)
* [Date](#date)
* [Flag](#flag)
* [Metric](#metric)
* [Property](#property)
* [Visit](#visit)

**Properties**

* [Audiences : Set&lt;Audience&gt;](#audiences--setaudience)
* [Badges : Set&lt;Badge&gt;](#badges--setbadge)
* [Dates : Set&lt;Date&gt;](#dates--setdate)
* [Current Visit : Visit](#current-visit--visit)
* [Creation Date : long](#creation-date--long)
* [Flags : Set&lt;Flag&gt;](#flags--setflag)
* [Metrics : Set&lt;Metric&gt;](#metrics--setmetrics)
* [Properties : Set&lt;Property&gt;](#properties--setproperty)
* Replaces : TODO
* Secondary Ids : TODO

### Nested Classes

#### Audience

**Inherits** [Attribute](#attribute)

**Properties**

* Name : string
 * value for the id in the ```audiences``` object

#### Attribute

**Properties**

* Id : string
 * Key of the various attribute objects
  
#### Badge

**Inherits** [Attribute](#attribute)

#### Date

**Inherits** [Attribute](#attribute)

**Properties**

* Timestamp
 * ms since epoch

#### Flag

**Inherits** [Attribute](#attribute)

**Properties**

* Value : boolean
 * value for an id in the ```flags``` object

#### Metric

**Inherits** [Attribute](#attribute)

**Properties**

* Value : float
 * value for an id in the ```metrics``` object

#### Property

**Inherits** [Attribute](#attribute)

**Properties**

* Value : string
 * value for an id in the ```properties``` object

#### Visit

**Properties**

* Creation : long
 * ms since epoch
* Dates : Set&lt;Date&gt;
* Flags : Set&lt;Flag&gt;
* Metrics : Set&lt;Metric&gt;
* Properties : Set&lt;Property&gt;
* Total Event Count : int

### Properties

#### Audiences : Set&lt;Audience&gt;

#### Badges : Set&lt;Badge&gt; 

#### Dates : Set&lt;Date&gt; 

#### Current Visit : Visit

#### Creation Date : long

#### Flags : Set&lt;Flag&gt;

#### Metrics : Set&lt;Metric&gt;

#### Properties : Set&lt;Property&gt;

#### Replaces
TODO

#### Secondary Ids
TODO