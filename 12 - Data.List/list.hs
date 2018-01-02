
-- Data.List 是关于 List 操作的模块
-- Prelude 导出了几个 Data.List 里的函数(如 map 和 filter)
import Data.List


-- 实现一个搜索子 List 的函数
search :: (Eq a) => [a] -> [a] -> Bool
search needle haystack =
    let nlen = length needle
    in foldl (\acc x -> if take nlen x == needle then True else acc) False (tails haystack)


main = do
    -- intersperse 取一个元素与 List 作参数, 并将该元素置于 List 中每对元素的中间
    print $ intersperse ',' "Hello"             -- "H,e,l,l,o"

    -- intercalate 取两个 List 作参数
    -- 它会将第一个 List 交叉插入第二个 List 中间, 并返回一个 List
    print $ intercalate "," ["Hello", "World"]  -- "Hello,World"

    -- transpose 函数可以反转一组 List 的 List
    -- 若将其视为 2D 的矩阵, 那 transpose 的操作就是将其列变为行
    let a = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    print $ transpose a     -- [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
    -- 如, 合并下列三个多项式 3x^2 + 5x + 9, 10x^3 + 9, 8x^3 + 5x^2 + x - 1
    let b = [[0, 3, 5, 9], [10, 0 , 0, 9], [8, 5, 1, -1]]
    print $ map sum $ transpose b

    -- concat 把一组 List 连接为一个 List
    print $ concat ["foo","bar","car"]      -- "foobarcar"

    -- concatMap 函数与 map 一个 List 之后再 concat 它等价
    -- print $ concat $ map (replicate 2) [1..4]
    print $ concatMap (replicate 2) [1..4]  -- [1,1,2,2,3,3,4,4]

    -- and 取一组 Bool List 作参数, 只有其中的值全为 True 的情况下才会返回 True
    print $ and $ map (== 4) $ replicate 5 4    -- True
    print $ and $ map (> 2) [2, 3, 4, 5]        -- False

    -- or 取一组 Bool List 作参数, 若其中存在一个 True 它就返回 True
    print $ or $ map (==4) [3..6]   -- True
    print $ or $ map (<3) $ filter (>4) [1..6]  -- False

    -- any 和 all 取一个限制条件和一组布林值 List 作参数, 检查是否该 List 的某个元素或每个元素都符合该条件
    print $ any (==4) [1..8]    -- True
    print $ all even $ replicate 3 $ 3*3     -- False

    -- iterate 取一个函数和一个值作参数
    -- 它会用该值去调用该函数并用所得的结果再次呼叫该函数，产生一个无限的 List
    print $ take 5 $ iterate (*2) 1     -- [1,2,4,8,16]

    -- splitAt 取一个 List 和数值作参数，将该 List 在特定的位置断开, 返回一个包含两个 List 的二元组
    print $ splitAt 5 "HelloWorld!"     -- ("Hello","World!")

    -- takeWhile 从一个 List 中取元素, 一旦遇到不符合条件的某元素就停止
    print $ takeWhile (\x -> x^3 < 100) [1..]   -- [1,2,3,4]
    print $ sum $ takeWhile (<10000) $ map (^2) [1..]   -- 328350

    -- dropWhile 与 takeWhile 相似, 不过它是扔掉符合条件的元素
    print $ dropWhile (/=' ') "Hello World!"    -- " World!"
    print $ dropWhile (<5) [1..10]      -- [5,6,7,8,9,10]

    -- span 与 takeWhile 有点像，只是它返回两个 List
    -- 第一个 List 与同参数调用 takeWhile 所得的结果相同，第二个 List 就是原 List 中余下的部分
    print $ let (first, rest) = span (/=' ') "Hello World!" in "First: " ++ first ++ "; Rest: " ++ rest
    -- span 是在条件首次为 False 时断开 List, 而 break 则是在条件首次为 True 时断开 List
    print $ break (==4) [1..5]      -- ([1,2,3],[4,5])

    -- sort 可以排序一个 List, 这一 List 的元素必须是 Ord 的实例
    print $ sort [8,5,3,2,1,6,4,2]  -- [1,2,2,3,4,5,6,8]
    print $ sort "This will be sorted soon"     -- "    Tbdeehiillnooorssstw"

    -- group 取一个 List 作参数, 并将其中相邻并相等的元素各自归类, 组成一个个子 List.
    print $ group [1,1,1,2,2,2,2,3,3,2,2,2,5,6,7]   -- [[1,1,1],[2,2,2,2],[3,3],[2,2,2],[5],[6],[7]]
    -- 若在 group 一个 List 之前给它排序就可以得到每个元素在该 List 中的出现次数
    let c = [1,1,1,1,2,2,3,2,2,2,5,6,7]
    print $ map (\l@(x:xs) -> (x, length l)) . group . sort $ c -- [(1,4),(2,5),(3,1),(5,1),(6,1),(7,1)]

    -- inits 和 tails 与 init 和 tail 相似, 只是它们会递归地调用自身直到什么都不剩
    print $ inits "Hello"   -- ["","H","He","Hel","Hell","Hello"]
    print $ tails "Hello"   -- ["Hello","ello","llo","lo","o",""]
    print $ let w = "Hello" in zip (tails w) (inits w)  -- [("Hello",""),("ello","H"),("llo","He"),("lo","Hel"),("o","Hell"),("","Hello")]
    print $ search "Hello" "Hello World!"

    -- isInfixOf 从一个 List 中搜索一个子 List, 若该 List 包含子 List, 则返回 True
    print $ "cat" `isInfixOf` "I'm a cat."      -- True
    print $ "Cat" `isInfixOf` "I'm a cat."      -- False

    -- isPrefixOf 与 isSuffixOf 分别检查一个 List 是否以某子 List 开头或者结尾
    print $ "Hey" `isPrefixOf` "Hey there"      -- True
    print $ "there" `isPrefixOf` "Hey there"    -- False
    print $ "Hey" `isSuffixOf` "Hey there"      -- False



