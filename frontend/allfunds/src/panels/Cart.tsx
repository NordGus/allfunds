import {CartAction, Item} from "../App.tsx";
import {Dispatch} from "react";
import {Listing} from "../components/Products/Listing.tsx";

type Props = {
    items: Item[]
    dispatch: Dispatch<CartAction>
}

function Cart({ items, dispatch }: Props) {
    if (items.length === 0) return (
        <div className="w-[25vw] flex flex-col justify-center items-center border-l-[1px] border-neutral-700">
            <span>Your cart is empty</span>
        </div>
    )

    return (
        <div className="w-[25vw] p-3 flex flex-col justify-center items-center gap-4 border-l-[1px] border-neutral-700">
            <a
                className="text-xl py-2 px-2 bg-neutral-300 hover:bg-neutral-400"
            >
                CHECKOUT {items.reduce((subtotal: number, item) => subtotal + (item.product.price * item.amount), 0)}€
            </a>
            <div className="flex-1 w-full flex flex-col gap-4 overflow-y-scroll">
                {
                    items.map(item => <Listing
                            key={`cart:${item.product.id}`}
                            name={item.product.name}
                            price={item.product.price}
                            amount={item.amount}
                            imageUrl={item.product.imageUrl}
                            onRemove={() => {
                                if (item.amount === 1) dispatch({type: "delete", product: item.product, amount: 0})
                                else dispatch({type: "update", product: item.product, amount: item.amount - 1})
                            }}
                            onAdd={() => dispatch({type: "update", product: item.product, amount: item.amount + 1})}
                        />
                    )
                }
            </div>
        </div>
    )
}

export default Cart