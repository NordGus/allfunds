import {CartAction, Item} from "../App.tsx";
import {Dispatch} from "react";
import {Listing} from "../components/Products/Listing.tsx";

type Props = {
    items: Item[]
    dispatch: Dispatch<CartAction>
    hide: boolean
    onHide: ((val: boolean) => void)
}

function Cart({ items, dispatch, hide, onHide }: Props) {
    return (
        <div
            className={hide ? "hidden" : "lg:w-[25vw] w-full h-[100vh] p-3 flex lg:flex-col flex-col-reverse justify-center items-center gap-4 border-l-[1px] border-neutral-700"}
        >
            {
                items.length === 0 ?
                    <div className="flex-1 flex justify-center items-center">
                        <span>Your cart is empty</span>
                    </div> :
                    <>
                        <a
                            className="text-2xl py-1 px-2 bg-neutral-300 hover:bg-neutral-400"
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
                                            if (item.amount === 1) dispatch({
                                                type: "delete",
                                                product: item.product,
                                                amount: 0
                                            })
                                            else dispatch({type: "update", product: item.product, amount: item.amount - 1})
                                        }}
                                        onAdd={() => dispatch({
                                            type: "update",
                                            product: item.product,
                                            amount: item.amount + 1
                                        })}
                                    />
                                )
                            }
                        </div>
                    </>
            }

            <div className="lg:hidden w-full flex justify-between items-center">
                <a className="cursor-pointer" onClick={() => onHide(true)}>
                    <svg
                        className="rotate-90 transform text-neutral-700 transition-all duration-300"
                        fill="none"
                        height="24"
                        width="24"
                        stroke="currentColor"
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        strokeWidth="2"
                        viewBox="0 0 24 24"
                    >
                        <polyline points="6 9 12 15 18 9"></polyline>
                    </svg>
                </a>
                <h3 className="text-2xl text-center">Cart</h3>
                <svg
                    className="text-transparent"
                    fill="none"
                    height="24"
                    width="24"
                    stroke="currentColor"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth="2"
                    viewBox="0 0 24 24"
                >
                    <polyline points="6 9 12 15 18 9"></polyline>
                </svg>
            </div>
        </div>
    )
}

export default Cart