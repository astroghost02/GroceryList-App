--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2024-12-06 21:27:01

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16385)
-- Name: user_name; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_name (
    user_id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(100) NOT NULL,
    email character varying(100) NOT NULL
);


ALTER TABLE public.user_name OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16388)
-- Name: User_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_user_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."User_user_id_seq" OWNER TO postgres;

--
-- TOC entry 4983 (class 0 OID 0)
-- Dependencies: 218
-- Name: User_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_user_id_seq" OWNED BY public.user_name.user_id;


--
-- TOC entry 229 (class 1259 OID 16464)
-- Name: cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart (
    user_id integer NOT NULL,
    item_id integer NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.cart OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16389)
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    category_id integer NOT NULL,
    category_name character varying(100) NOT NULL
);


ALTER TABLE public.category OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16392)
-- Name: category_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.category_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.category_category_id_seq OWNER TO postgres;

--
-- TOC entry 4984 (class 0 OID 0)
-- Dependencies: 220
-- Name: category_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.category_category_id_seq OWNED BY public.category.category_id;


--
-- TOC entry 221 (class 1259 OID 16393)
-- Name: grocerylist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grocerylist (
    grocerylist_id integer NOT NULL,
    list_name character varying(100) NOT NULL,
    user_id integer,
    created_date date NOT NULL
);


ALTER TABLE public.grocerylist OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16396)
-- Name: grocerylist_grocerylist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.grocerylist_grocerylist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.grocerylist_grocerylist_id_seq OWNER TO postgres;

--
-- TOC entry 4985 (class 0 OID 0)
-- Dependencies: 222
-- Name: grocerylist_grocerylist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.grocerylist_grocerylist_id_seq OWNED BY public.grocerylist.grocerylist_id;


--
-- TOC entry 223 (class 1259 OID 16397)
-- Name: item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item (
    item_id integer NOT NULL,
    item_name character varying(100) NOT NULL,
    price numeric(10,2) NOT NULL,
    unit character varying(50),
    category_id integer
);


ALTER TABLE public.item OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16400)
-- Name: item_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.item_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.item_item_id_seq OWNER TO postgres;

--
-- TOC entry 4986 (class 0 OID 0)
-- Dependencies: 224
-- Name: item_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.item_item_id_seq OWNED BY public.item.item_id;


--
-- TOC entry 225 (class 1259 OID 16401)
-- Name: listitem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.listitem (
    list_item_id integer NOT NULL,
    list_id integer,
    item_id integer,
    quantity integer NOT NULL
);


ALTER TABLE public.listitem OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16404)
-- Name: listitem_list_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.listitem_list_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.listitem_list_item_id_seq OWNER TO postgres;

--
-- TOC entry 4987 (class 0 OID 0)
-- Dependencies: 226
-- Name: listitem_list_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.listitem_list_item_id_seq OWNED BY public.listitem.list_item_id;


--
-- TOC entry 232 (class 1259 OID 16495)
-- Name: prices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prices (
    store_id integer NOT NULL,
    item_id integer NOT NULL,
    price numeric NOT NULL,
    item_name character varying(100)
);


ALTER TABLE public.prices OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16409)
-- Name: storeitem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.storeitem (
    store_item_id integer NOT NULL,
    store_id integer,
    item_id integer,
    price numeric(10,2) NOT NULL,
    availability boolean NOT NULL
);


ALTER TABLE public.storeitem OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16412)
-- Name: storeitem_store_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.storeitem_store_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.storeitem_store_item_id_seq OWNER TO postgres;

--
-- TOC entry 4988 (class 0 OID 0)
-- Dependencies: 228
-- Name: storeitem_store_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.storeitem_store_item_id_seq OWNED BY public.storeitem.store_item_id;


--
-- TOC entry 231 (class 1259 OID 16487)
-- Name: stores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stores (
    store_id integer NOT NULL,
    store_name character varying(100) NOT NULL
);


ALTER TABLE public.stores OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16486)
-- Name: stores_store_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stores_store_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stores_store_id_seq OWNER TO postgres;

--
-- TOC entry 4989 (class 0 OID 0)
-- Dependencies: 230
-- Name: stores_store_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stores_store_id_seq OWNED BY public.stores.store_id;


--
-- TOC entry 4781 (class 2604 OID 16413)
-- Name: category category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category ALTER COLUMN category_id SET DEFAULT nextval('public.category_category_id_seq'::regclass);


--
-- TOC entry 4782 (class 2604 OID 16414)
-- Name: grocerylist grocerylist_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grocerylist ALTER COLUMN grocerylist_id SET DEFAULT nextval('public.grocerylist_grocerylist_id_seq'::regclass);


--
-- TOC entry 4783 (class 2604 OID 16415)
-- Name: item item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item ALTER COLUMN item_id SET DEFAULT nextval('public.item_item_id_seq'::regclass);


--
-- TOC entry 4784 (class 2604 OID 16416)
-- Name: listitem list_item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listitem ALTER COLUMN list_item_id SET DEFAULT nextval('public.listitem_list_item_id_seq'::regclass);


--
-- TOC entry 4785 (class 2604 OID 16418)
-- Name: storeitem store_item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.storeitem ALTER COLUMN store_item_id SET DEFAULT nextval('public.storeitem_store_item_id_seq'::regclass);


--
-- TOC entry 4786 (class 2604 OID 16490)
-- Name: stores store_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stores ALTER COLUMN store_id SET DEFAULT nextval('public.stores_store_id_seq'::regclass);


--
-- TOC entry 4780 (class 2604 OID 16419)
-- Name: user_name user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_name ALTER COLUMN user_id SET DEFAULT nextval('public."User_user_id_seq"'::regclass);


--
-- TOC entry 4973 (class 0 OID 16464)
-- Dependencies: 229
-- Data for Name: cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart (user_id, item_id, quantity) FROM stdin;
3	2	1
3	1	4
10	1	1
10	2	1
\.


--
-- TOC entry 4963 (class 0 OID 16389)
-- Dependencies: 219
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category (category_id, category_name) FROM stdin;
1	Beverages
2	Dairy
3	Snacks
4	Frozen Foods
5	Bakery
\.


--
-- TOC entry 4965 (class 0 OID 16393)
-- Dependencies: 221
-- Data for Name: grocerylist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grocerylist (grocerylist_id, list_name, user_id, created_date) FROM stdin;
1	John's Weekly List	1	2024-10-10
2	Jane's Shopping List	2	2024-10-11
\.


--
-- TOC entry 4967 (class 0 OID 16397)
-- Dependencies: 223
-- Data for Name: item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item (item_id, item_name, price, unit, category_id) FROM stdin;
1	Milk	3.50	gallon	2
2	Bread	2.00	loaf	5
3	Cookies	4.25	box	3
4	Frozen Pizza	7.50	box	4
5	Orange Juice	5.00	bottle	1
\.


--
-- TOC entry 4969 (class 0 OID 16401)
-- Dependencies: 225
-- Data for Name: listitem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.listitem (list_item_id, list_id, item_id, quantity) FROM stdin;
1	1	1	2
2	1	2	1
4	2	4	1
\.


--
-- TOC entry 4976 (class 0 OID 16495)
-- Dependencies: 232
-- Data for Name: prices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prices (store_id, item_id, price, item_name) FROM stdin;
1	1	3.50	Milk
2	1	3.75	Milk
3	1	3.40	Milk
4	1	3.60	Milk
1	2	2.00	Bread
2	2	2.10	Bread
3	2	1.90	Bread
4	2	2.05	Bread
1	3	4.25	Cookies
2	3	4.50	Cookies
3	3	4.10	Cookies
4	3	4.30	Cookies
1	4	5.00	Orange Juice
2	4	5.25	Orange Juice
3	4	4.90	Orange Juice
4	4	5.10	Orange Juice
1	5	7.50	Frozen Pizza
2	5	7.75	Frozen Pizza
3	5	7.40	Frozen Pizza
4	5	7.60	Frozen Pizza
\.


--
-- TOC entry 4971 (class 0 OID 16409)
-- Dependencies: 227
-- Data for Name: storeitem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.storeitem (store_item_id, store_id, item_id, price, availability) FROM stdin;
1	1	1	3.50	t
2	1	2	2.00	t
3	1	3	4.25	f
4	2	4	7.50	t
5	2	5	5.00	t
\.


--
-- TOC entry 4975 (class 0 OID 16487)
-- Dependencies: 231
-- Data for Name: stores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stores (store_id, store_name) FROM stdin;
1	Walmart
2	Target
3	Costco
4	Kroger
\.


--
-- TOC entry 4961 (class 0 OID 16385)
-- Dependencies: 217
-- Data for Name: user_name; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_name (user_id, username, password, email) FROM stdin;
1	john_doe	password123	john.doe@example.com
2	jane_smith	securepass456	jane.smith@example.com
15	aditya_,madiya	securepassword	amadiya@example.com
3	user123	user	user123@example.com
4	hsbadri	Haindavi	hsbadri@example.com
5	astro	astro	astro@example.com
6	sample	sample	sample@example.com
7	tejo	tejo1234	tejo@example.com
8	cse412	cse	cse412@example.com
9	cse412class	class	cse412class@example.com
10	test123	test	test123@example.com
\.


--
-- TOC entry 4990 (class 0 OID 0)
-- Dependencies: 218
-- Name: User_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_user_id_seq"', 10, true);


--
-- TOC entry 4991 (class 0 OID 0)
-- Dependencies: 220
-- Name: category_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_category_id_seq', 5, true);


--
-- TOC entry 4992 (class 0 OID 0)
-- Dependencies: 222
-- Name: grocerylist_grocerylist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.grocerylist_grocerylist_id_seq', 2, true);


--
-- TOC entry 4993 (class 0 OID 0)
-- Dependencies: 224
-- Name: item_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.item_item_id_seq', 5, true);


--
-- TOC entry 4994 (class 0 OID 0)
-- Dependencies: 226
-- Name: listitem_list_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.listitem_list_item_id_seq', 4, true);


--
-- TOC entry 4995 (class 0 OID 0)
-- Dependencies: 228
-- Name: storeitem_store_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.storeitem_store_item_id_seq', 5, true);


--
-- TOC entry 4996 (class 0 OID 0)
-- Dependencies: 230
-- Name: stores_store_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stores_store_id_seq', 4, true);


--
-- TOC entry 4788 (class 2606 OID 16421)
-- Name: user_name User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_name
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (user_id);


--
-- TOC entry 4800 (class 2606 OID 16468)
-- Name: cart cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pkey PRIMARY KEY (user_id, item_id);


--
-- TOC entry 4790 (class 2606 OID 16423)
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);


--
-- TOC entry 4792 (class 2606 OID 16425)
-- Name: grocerylist grocerylist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grocerylist
    ADD CONSTRAINT grocerylist_pkey PRIMARY KEY (grocerylist_id);


--
-- TOC entry 4794 (class 2606 OID 16427)
-- Name: item item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_pkey PRIMARY KEY (item_id);


--
-- TOC entry 4796 (class 2606 OID 16429)
-- Name: listitem listitem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listitem
    ADD CONSTRAINT listitem_pkey PRIMARY KEY (list_item_id);


--
-- TOC entry 4806 (class 2606 OID 16501)
-- Name: prices prices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prices
    ADD CONSTRAINT prices_pkey PRIMARY KEY (store_id, item_id);


--
-- TOC entry 4798 (class 2606 OID 16433)
-- Name: storeitem storeitem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.storeitem
    ADD CONSTRAINT storeitem_pkey PRIMARY KEY (store_item_id);


--
-- TOC entry 4802 (class 2606 OID 16492)
-- Name: stores stores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY (store_id);


--
-- TOC entry 4804 (class 2606 OID 16494)
-- Name: stores stores_store_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stores
    ADD CONSTRAINT stores_store_name_key UNIQUE (store_name);


--
-- TOC entry 4812 (class 2606 OID 16474)
-- Name: cart cart_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.item(item_id);


--
-- TOC entry 4813 (class 2606 OID 16469)
-- Name: cart cart_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.user_name(user_id);


--
-- TOC entry 4807 (class 2606 OID 16434)
-- Name: grocerylist grocerylist_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grocerylist
    ADD CONSTRAINT grocerylist_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.user_name(user_id);


--
-- TOC entry 4808 (class 2606 OID 16439)
-- Name: item item_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(category_id);


--
-- TOC entry 4809 (class 2606 OID 16444)
-- Name: listitem listitem_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listitem
    ADD CONSTRAINT listitem_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.item(item_id);


--
-- TOC entry 4810 (class 2606 OID 16449)
-- Name: listitem listitem_list_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listitem
    ADD CONSTRAINT listitem_list_id_fkey FOREIGN KEY (list_id) REFERENCES public.grocerylist(grocerylist_id);


--
-- TOC entry 4814 (class 2606 OID 16507)
-- Name: prices prices_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prices
    ADD CONSTRAINT prices_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.item(item_id);


--
-- TOC entry 4815 (class 2606 OID 16502)
-- Name: prices prices_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prices
    ADD CONSTRAINT prices_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.stores(store_id);


--
-- TOC entry 4811 (class 2606 OID 16454)
-- Name: storeitem storeitem_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.storeitem
    ADD CONSTRAINT storeitem_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.item(item_id);


--
-- TOC entry 4982 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2024-12-06 21:27:01

--
-- PostgreSQL database dump complete
--

