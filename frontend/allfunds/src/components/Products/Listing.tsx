type Props = {
    name: string,
    imageUrl: string
    price: number,
    amount: number
    onRemove: (() => void)
    onAdd: (() => void)
}

export function Listing({ name, price, imageUrl, amount, onRemove, onAdd }: Props) {
    return (
        <div className="w-full grid grid-cols-item grid-rows-1 gap-2">
            <div className="h-[10vh] w-[10vh] flex justify-center items-center overflow-clip">
                <img className="h-full" src={ imageUrl } alt={ name }/>
            </div>
            <div className="flex flex-col justify-between gap-2">
                <h4>{name}</h4>
                <div className="flex justify-center items-center gap-4">
                    <a
                        className="cursor-pointer text-xl py-1 px-2"
                        onClick={onRemove}
                    >-</a>
                    <span className="text-xl">{ amount }</span>
                    <a
                        className="cursor-pointer text-xl py-1 px-2"
                        onClick={onAdd}
                    >+</a>
                </div>
            </div>
            <div className="flex justify-center items-center">
                <p>{price * amount}€</p>
            </div>
        </div>
    )
}