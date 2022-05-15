-- exploring dataset
select * 
from listings_detailed;

select * 
from listings_detailed order by price;

-- formatting price column and changing type
update listings_detailed 
set price =  replace(price,'$','');

update listings_detailed 
set price =  replace(price,',','');

alter table listings_detailed
 modify column price decimal;

-- formatting amenities column
update listings_detailed 
set amenities =  replace(amenities,'[','');

update listings_detailed 
set amenities =  replace(amenities,']','');

update listings_detailed 
set amenities =  replace(amenities,'"','');

-- removing outliers that would skew analysis
select * 
from listings_detailed 
where price = '0.00';

delete from listings_detailed 
where price=0;

select name,host_name, property_type, price 
from listings_detailed 
where name like '%harvey%' 
order by price;

delete from listings_detailed 
where name like '%hurricane%' or name like '%Harvey%';

delete from listings_detailed 
where room_type = 'Hotel room';

delete from listings_detailed 
where host_id = 194953121;

select *, count(name) 
from listings_detailed 
where host_name = '' 
group by host_id ;

delete from listings_detailed 
where host_name = '';

-- joining listings and neighbourhood tables by zip code
select n.neighbourhood, l.room_type, count(l.name) as listings_count, round(avg(l.price),2) as avg_price, round(avg(l.review_scores_value),2) as avg_review, round(avg(cast(review_scores_location as double)),2) as avg_location_reviews 
from listings_detailed l 
inner join austin_neighbourhoods n on l.neighbourhood_cleansed = n.zip_code 
group by n.neighbourhood, l.room_type 
order by avg_location_reviews;

create view neighbourhoods_added as select name, host_id, neighbourhood_cleansed, room_type, price, review_scores_value, neighbourhood from listings_detailed l inner join austin_neighbourhoods n on l.neighbourhood_cleansed = n.zip_code group by neighbourhood;

-- seeing if prices/reviews change during big events such as festivals
select name, avg(price), avg(review_scores_value) 
from listings_detailed 
group by name like '%SXSW%' or name like '%ACL%';

-- seeing if being a sueprhost has any effect on price or reviews
select host_is_superhost, count(host_id) as host_count, avg(price) as avg_price, avg(cast(review_scores_value as double)) as avg_review_value,  avg(review_scores_communication) as avg_communiation_reviews, avg(calculated_host_listings_count) as avg_host_listings_count 
from listings_detailed 
group by host_is_superhost;

-- describing listings by room type
select room_type, count(name), floor(avg(accommodates)), avg(price) 
from listings_detailed 
group by room_type;

-- describing lisitngs by zip code 
select neighbourhood_cleansed, count(name) as property_count, round(avg(price),2) as avg_price, round(avg(cast(review_scores_value as double)),2) as avg_reviews, round(avg(reviews_per_month),2) as avg_reviews_per_month,floor(avg(accommodates)) as avg_accommodates, floor(avg(minimum_nights)) as avg_min_nights 
from listings_detailed 
group by neighbourhood_cleansed 
order by avg_reviews desc;

-- creating a view of the hosts with the most listings for further analysis later 
create view top_30_hosts_by_property_count 
as select host_name, calculated_host_listings_count, host_location, host_since, host_response_time, host_response_rate, host_acceptance_rate, host_identity_verified, host_is_superhost, avg(price) 
from listings_detailed 
group by host_id 
order by calculated_host_listings_count 
desc limit 30;

select host_name, calculated_host_listings_count, host_location, host_since, host_response_time, host_response_rate, host_acceptance_rate, host_identity_verified, host_is_superhost, avg(price) as avg_price, avg(review_scores_value) as avg_review 
from listings_detailed 
group by host_id 
order by calculated_host_listings_count 
desc limit 30;

-- comparing price vs price per bedroom
select neighbourhood_cleansed, count(name), avg(accommodates), avg(bedrooms), avg(beds), avg(minimum_nights), sum(number_of_reviews), avg(review_scores_value),avg(price) , avg(price)/avg(bedrooms) as price_per_bedroom 
from listings_detailed 
group by neighbourhood_cleansed  
order by price_per_bedroom desc;

-- determining which amenities affect price the most
select room_type, count(name), avg(price), avg(minimum_nights), avg(review_scores_value) 
from listings_detailed 
group by room_type;

select room_type, count(name), avg(price), avg(minimum_nights), avg(review_scores_value) 
from listings_detailed 
where amenities like '%pool%' 
group by room_type;

select room_type, count(name), avg(price), avg(minimum_nights), avg(review_scores_value) 
from listings_detailed 
where amenities like '%hot tub%' 
group by room_type;

select room_type, count(name), avg(price), avg(minimum_nights), avg(review_scores_value) 
from listings_detailed 
where amenities like '%grill%' 
group by room_type;

select room_type, count(name), avg(price), avg(minimum_nights), avg(review_scores_value) 
from listings_detailed 
where amenities like '%fireplace%' 
group by room_type;

select room_type, count(name), avg(price), avg(minimum_nights), avg(review_scores_value) 
from listings_detailed 
where amenities like '%GYM%' 
group by room_type;

select room_type, count(name), avg(price), avg(minimum_nights), avg(review_scores_value) 
from listings_detailed 
where amenities like '%pets%' 
group by room_type;

select room_type, count(name), avg(price), avg(minimum_nights), avg(review_scores_value) 
from listings_detailed 
where amenities like '%Waterfront%' 
group by room_type;
