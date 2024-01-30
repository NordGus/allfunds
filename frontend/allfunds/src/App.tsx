import {useEffect, useReducer, useState} from "react";
import {Preview} from "./components/Products/Preview.tsx";
import {Listing} from "./components/Products/Listing.tsx";

function App() {
    const [cart, cartDispatch] = useReducer(cartReducer, initialCart)
    const [products, setProducts] = useState(new Array<Product>())

    useEffect(() => {
        fetch("http://localhost:3000/grocery",
            { headers: { "Content-Type": "application/json" } }
        ).then(response => {
            if (response.ok) return response.json()
        }).then((products: ProductResponse[]) => {
            setProducts(products.map(product => {
                return {
                    id: product.id,
                    imageUrl: product.image_url,
                    stock: product.stock,
                    name: product.productName,
                    description: product.productDescription,
                    price: product.price,
                    favorite: product.favorite,
                }
            }))
        })
        .catch(err => console.error(err))
    }, []);

    return (
        <div className="flex gap-2">
            <div className="flex-1 flex flex-wrap px-6 py-10 gap-6 justify-between h-[100vh] overflow-y-scroll">
                {
                    products.length === 0 ? <span>Loading</span> : products.map(
                        product => <Preview
                            key={product.id}
                            name={product.name}
                            price={`${product.price}€`}
                            stock={product.stock}
                            description={product.description}
                            imageUrl={product.imageUrl}
                            onAdd={() => cartDispatch({type: "add", product: product, amount: 1})}
                        />
                    )
                }
            </div>
            <div className="w-[25vw] p-3 flex flex-col justify-center items-center gap-4 border-l-[1px] border-neutral-700">
                { cart.length === 0 ?
                    <span>Your cart is empty</span> : <>
                        <a
                            className="text-xl py-2 px-2 bg-neutral-300 hover:bg-neutral-400"
                        >
                            CHECKOUT {cart.reduce((subtotal: number, item) => subtotal + (item.product.price * item.amount), 0)}€
                        </a>
                        <div className="flex-1 flex flex-col gap-4 overflow-y-scroll">
                            {
                                cart.map(item => <Listing
                                        key={`cart:${item.product.id}`}
                                        name={item.product.name}
                                        price={item.product.price}
                                        amount={item.amount}
                                        imageUrl={item.product.imageUrl}
                                        onRemove={() => {
                                            if (item.amount === 1) cartDispatch({type: "delete", product: item.product, amount: 0})
                                            else cartDispatch({type: "update", product: item.product, amount: item.amount - 1})
                                        }}
                                        onAdd={() => cartDispatch({type: "update", product: item.product, amount: item.amount + 1})}
                                    />
                                )
                            }
                        </div>
                    </>
                }
            </div>
        </div>
    )
}

export default App;

type ProductResponse = {
    id: string,
    image_url: string,
    stock: number,
    productName: string,
    price: number,
    productDescription: string,
    favorite: number
}

type Product = {
    id: string,
    imageUrl: string,
    stock: number,
    name: string,
    description: string,
    price: number,
    favorite: number,
}

type Item = {
    product: Product,
    amount: number
}

type CartState = Item[]

type CartStateAction = {
    type: string
    product: Product
    amount: number
}

function cartReducer(state: CartState, action: CartStateAction): CartState {
    switch (action.type) {
        case "add": {
            if (state.find(item => item.product.id === action.product.id)) return state

            return [...state, { product: action.product, amount: action.amount }]
        }
        case "update": {
            return state.map(item => {
                if (item.product.id === action.product.id) return { product: action.product, amount: action.amount }
                return item
            })
        }
        case "delete": {
            return state.filter(item => item.product.id !== action.product.id)
        }
        default: {
            throw Error("Unknown action: " + action.type)
        }
    }
}

const initialCart: CartState = []